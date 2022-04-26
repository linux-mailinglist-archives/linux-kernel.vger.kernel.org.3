Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD750FC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbiDZMN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349813AbiDZMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:13:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6AA222B3;
        Tue, 26 Apr 2022 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650975032; x=1682511032;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=R2vrd2HzhP7pv0zRUidGEu4ZTfY2r8W1BtZmpM9QIGo=;
  b=K90mx0yHDZ296FEa56o8hvvKW84LcPwpi3GLP3FMyZjH+3YkRA9uzvFr
   b0SmBAy09shSG6O7Ag9dsiFIDLSbe77NiWj/6fVfdjHy251cSrCzuAfFN
   GDGTB8LFzC+PtqJoXzhA7E1cYob7sl1MHSTmWpHF532+MofA3iRuG3pBP
   w09e6llQqV5UZTZJEfZZ5zvTUxwOO6xPrtnIfKEurQ2aZ2lddkcxDx7DE
   B3abx0M9FmgUPOipYR0x0b9oy745JNKQCNbrjaJOrQN72u9dPaWuu2jUr
   Ip2NudEQONTB6UH8PaXMxlxp/yzFBOdDe8Zbo8npXb3V3IJiDRVdH8LS+
   A==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643644800"; 
   d="scan'208";a="203716674"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2022 20:10:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qna/nHSVmR2z9bZIOyn1Vu8Zg3eaHbpOny+lpRTyIMVhByWCkkjC4L/jv555KfToUTTa1r/wgkY91AojJAi4vIIenEN1F/IBtDaanS3YOh4AbjhbdOn4GzN4djW8Az92Uz6FW5AfbqS4eLxmVuRa4LnDkzy9YujdcEz4j+PCPdyZDEAY25B4S1oRr5XcAf4dxcv3FaYUEXTf3rwSkJl0MiLecPRmiW3VakDY8Yqcb/YwF9yqKQFP/9EEJW/LzN2Wkl6hkI62UghC344t4tndcVf+kwF8I8rg5QTHR6DwcdiLqGSTWpKUoEfZMQo281ZuiSqWCHT+BegcMfssTTDndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2vrd2HzhP7pv0zRUidGEu4ZTfY2r8W1BtZmpM9QIGo=;
 b=CrGLNECVldARjlkSa/ekv9MpR+82nruWNYvUMFVom3llACVQnY/yNZrXllK9DGXY1DnO2nK+W0fxnUb/CCks4QX8aisL3zhwp3wX7y6s5RipjDehlwFfSw0tX10MDzN/ShWwIPSNOZ3FGQnyV3TRfypOwIkt7pNrmEpOXOfdVznZhryeG9aZMh3YbmZ+B8qCTAvnkKV24YESUocPpne6H+YPnYEfph94+zNkT+n3llhWxK2OTtc/VuGMRQMc7L3T1UMsF9xw2t0D/t9LF9p1gXriIibVgTd27xclitZoYRKxMWAGzTxICzKanGZOtC+ZdQVIaAaq8y2ThNcqoVinGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2vrd2HzhP7pv0zRUidGEu4ZTfY2r8W1BtZmpM9QIGo=;
 b=aWMIRa8InT54c71HIpEXEs0Yw+Jyu0QUbO47jVWDaIL2V85j+5GFktE1AccOC8E51NMHZWj66NOa1dVcF3yjyBjg7JtzF8dDw6Q4JQyzLBDqPNG4s9Rx82TKrOHbQGB3NUrGxBKfM/GJ35LP8fxGfuG3cN2ja65VvFHgS7HzyBs=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by BN3PR04MB2131.namprd04.prod.outlook.com (2a01:111:e400:7bbc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 12:10:28 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::eda4:f764:fae0:b89e]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::eda4:f764:fae0:b89e%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:10:28 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Remove duplicate include in ufshcd
Thread-Topic: [PATCH] scsi: ufs: Remove duplicate include in ufshcd
Thread-Index: AQHYWVrEcCA7RAkzTEWdlSpo1r9JAa0CGlhQ
Date:   Tue, 26 Apr 2022 12:10:28 +0000
Message-ID: <BL0PR04MB6564679F152563C20CB121B3FCFB9@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20220426104509.621394-1-wanjiabing@vivo.com>
In-Reply-To: <20220426104509.621394-1-wanjiabing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a4ed34d-4312-44c4-54d0-08da277dc0c1
x-ms-traffictypediagnostic: BN3PR04MB2131:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2131395704DA26C8D61EA7EFFCFB9@BN3PR04MB2131.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: My5p2K3YUs5RmFmn4EQco7+oHMxXkELjW/CpM1Afofp2W/E/hKiSeyN92XMRGcsEvuaLcRf8eI1hPnpgD7wzxecELypnZEW3M0INPTwdhk/0A1N22aaUEitZp8eHlDQpA6+68+qCd/VfPiO1+GvMjDHxV5PItnt5/dPtle5Ir/UiTRRsKn+pgRHn/1+fwoqCYv2sX3v+lG+wxDpSRuqMdKjjnYhNeu1oMVMaB4ttPuC6kyu3oUTtGU2bhiNJTUtBcdaCR+LZZbXBeNZBst8Q/zq2Zoh0k9l9QasFJDQKz2E/Sc0ljTr0rtInGmbn5ifeUa6Ih3X2Nx3iW/dUa95hjRppjIG20VflHGs4MVSYMs0dhihUDoiUq1ROJ4XKNX7UNeEH5L7Du3iW8+YxKif0r8jVrgnra7RMMbscqVNITq92uKH0N7Ozh0AhbP/gT4pqWQUIofrhPyr8eAZrjJV4isJaK+RSCzDqOw+2/we/1nLMDJOZEVCrZAAc3Y9C0Hi5dUoSEzyKAq8marf8npr3p0G7PINd504IKA6HNtQ1ZiPlgl/ad0/o083MBK99dzC7qntGNdB+euy52MutdVbPWAW0Y6RhoCEFzApZZ81T6WDKnoOkaTvbR7nAj1oPPEKF9mQPvzPonwjmwBvofURfboeWp4fBoOjONWBByWAKNhHNCyIkiUTTv7QH8H1anqy6Ds7csVjTIzgyORLra/ODR8BSOLx+sBNiem/Q5DOXreM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(2906002)(55016003)(66446008)(66476007)(122000001)(8676002)(9686003)(110136005)(5660300002)(38100700002)(83380400001)(52536014)(38070700005)(86362001)(7416002)(8936002)(6506007)(508600001)(66556008)(558084003)(64756008)(66946007)(186003)(76116006)(921005)(33656002)(316002)(71200400001)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lVXXlkb/TIYgEdh90hAMc6byp3zHCiapUPsk8v0ts/cvO8x0SDxkS9NQsKpa?=
 =?us-ascii?Q?qWz90REvuQuvUG5DeRNFNVheg1cu7lrR6TALs3C7ZEfHaAm6BwdDlLaqGGWJ?=
 =?us-ascii?Q?fuTsXukIFtujGL1HFvAZOtN4vFSbGQnCjZ4mEa6CD5YiIFrOv8kMY/pTABOO?=
 =?us-ascii?Q?KO7rb/1AlZkYFhVi+gBQHWJ2XV6STMKOlDMv7J67uLyu05c3eC22fpK6lNyz?=
 =?us-ascii?Q?n1Xz16qy2M3UJb1CITpnKjRY0U1L/yHvT6U88N45ptE7CTZVjQTcGn6FXcWo?=
 =?us-ascii?Q?9sXgtFi1EAH+aPfHXodkizTHcX45T4i84/iO/MzHGQc9xGixmUpU89NJegaa?=
 =?us-ascii?Q?aRIMiJfREN9jZcGTf5hBHjrbIoDER8oSg+LdR53RrT0vFYE1dGM/etZHpk2G?=
 =?us-ascii?Q?SiIEKtqRlRAIGRPaYkwzvZA4ohfSJ1GGFnbIol+oswHGf7JVW2alaSDoivXl?=
 =?us-ascii?Q?oy2YUVFjeXjPNaplElnsOS4LibhiKF2MgIJXlKC3ZqM9cS5S8jW81uohcTIS?=
 =?us-ascii?Q?K1C4iawp3vxWymj5YUuC3jAqzJKd3UPXY5zvPnl9smKfVYUla4lhrrxHka6v?=
 =?us-ascii?Q?mYG6ERbd71sHxuRmzhyjEMitf6sn3dtloIMKcNqK5em/4mU/vW8hpyanv6p5?=
 =?us-ascii?Q?CD7FjIW43z3ek761h9ZD32cSHBJF8GbLE/iLjMFxXB/jf6nKnGASTiBEPj4f?=
 =?us-ascii?Q?fiM6a43KoF4T56H6jAIijFUSvM1cmg0N/4n1t7XemoF4GsXLGP7ahXh5WNYh?=
 =?us-ascii?Q?Pt7YfTfN7AdOCcUnZNhMqFko0NSq+vnCMoO11Ax0vvPMi1DmVIYoLWvSLiy1?=
 =?us-ascii?Q?kOhy0hrfQXcR8mqUCI2XJkIdPxjbyuTXmBhZugI+pR0Ki2Vnh8K7UdeggYJY?=
 =?us-ascii?Q?dKojtxVNJSZLLmay9eA1I4jJ5H/LyF/GOIzwnlrG62AVha/6cKD+AuRRyoGq?=
 =?us-ascii?Q?DyXNTeBDXFVmk8z55ic9odk6z+JHjfx32e3yp/1VlHCkbwabtMkHXVjLHaev?=
 =?us-ascii?Q?q0VJt2PeV/lFRCdtWII0+eSvfMF19pifJbGxmUzSRcSLAuI9U68xWN2/ZhWa?=
 =?us-ascii?Q?jcI5TN8Tm9rewTt/MEkSWuCej58IrFoXWHtc3sQoZQtWA3wIygxzS4CaZGzJ?=
 =?us-ascii?Q?By1jjaxLQPuS1OnC/Taa0zUSjxrRmiAR1pcqycIBl3kaBtHQlFsWKJ5+xpYr?=
 =?us-ascii?Q?ZeVQxn6k49JHYa0tBFRMw1nEwpQY+AYxifK8FHDxup2M97wMY+TB12009k9r?=
 =?us-ascii?Q?FrmXjD/QSHAdHOECwGB8AsQa48/fko2DvcoivmjBaXHXrWMGdvH+0o2itcx2?=
 =?us-ascii?Q?ZC+JTnyz/NTWyxZj42tGXUqrridBaXE47OPDhKdxKM1erkFFHROcQISV23F1?=
 =?us-ascii?Q?y5N30RI8zhR3fZbrHZ0xuJA/iSUgCyHeIAEk5q45WK/mDVuptv6SkEFrULa0?=
 =?us-ascii?Q?/6NsNdyT+OXTR1ZaHACu5rsZ24q/thFavFB4NHEowYj8M3dnxOuyzsHBQUBH?=
 =?us-ascii?Q?1Oe8eYKvw84UaUF2fJ9HGI2nLsxrO0fJtCNR3qi3wUzQl7CYaCzgXBmbS0hZ?=
 =?us-ascii?Q?CqCrWYlwyp5TfiQlyctAqoDYv8iSx8uBnw55m+qXupQXDntNCuOM4SCRZE89?=
 =?us-ascii?Q?37rKAv7CMLhS8XOSF5SMJl1JTRjXTyxMwg4x9J8V5PX/nArqBIozp8wHZUxp?=
 =?us-ascii?Q?mQM9zW2VY9XgdKAZSpg0T5yOFh3kCOd2OH6vCqWQC+OaXfvEwRoDBqLXoEH2?=
 =?us-ascii?Q?B4WAFa1uOQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ed34d-4312-44c4-54d0-08da277dc0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 12:10:28.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7SZHVykLBQxA8TQR1/O5OAEp67DJ8ozgfYOcvMb4MzTtI7j6Tb5KXiavmMIrSHWeoFgf42O46QdMSH5kP6mkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2131
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Fix following checkincludes warning:
> drivers/scsi/ufs/ufshcd.c: linux/nls.h is included more than once.
>=20
> The include is in line 14. Remove the duplicated here.
>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
