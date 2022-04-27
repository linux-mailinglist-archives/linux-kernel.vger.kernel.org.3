Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EF511595
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiD0LAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiD0LAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:00:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277143D1240
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651055929; x=1682591929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s/quhmMASiGQDOZQOLFqMz4GMkyRanzbD0FJL4tsntA=;
  b=api0zCrNbZkZMEMUBMb7v02hyhPxIt3HAGwUa2vc/MkiJeCAaqcYGXcG
   zCC/r/0+uOayGYZ0JCodhzkY7GxFm1p6vvJLcMRMrKIYKJNOb/5qLDCkb
   6w4Ro7xytTgiuExzwCRiTYfTve3G6E3aI/RCgFgRrqNZF1804KnlyJEgf
   fpmVZi7qnqkDP+aaXi48OUnUeX39qH/YL/LfFBO8jQHEyyAhzhc/X0NQs
   KMfKY3U8iC2Uv04awfUBEppJljA/z6STaGbUmboaXwuDVwqPM0d6kYUWE
   F/9uCpDa3xEL7YlZFuh3FWZ9LaQvPOuBQytFHlWhROQyteUIIJLgGfD3x
   w==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="203818395"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 18:38:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX2Hh9u9TEIeLvZ19C2M39U9QBXUSsoorpMuCWgpAf/evdHQaoGL86A469hQcTfsNI5xQ1ZYRmlRW0+5GOKQzYmkXfLHE2L3NMVBZBtkjnGJsn+pvEEiomWvna0ob94rVQEk7pchJE++/ShSa/w/YgNSP88mXKhJYYiq2Sn+DKXlYocpiRL3favzn8hvq4leMKn/HrbNQiznkTEdCEx46hVnpS7Gzd2Eur7OpBrpLxRFQ3WqkkS52X5kjz4DJ3r11G1hylGmTnU4zJoikrJ4GofcqdkaisZBEBrhCJlSWOVriE48cSRYInyTRlAWiYaRoZOhjEeby3N7ZPKVu6ziXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/quhmMASiGQDOZQOLFqMz4GMkyRanzbD0FJL4tsntA=;
 b=fKPC9l6C1kQ7terLZuHu7tvCI7+Ina0yPz+RjKGmo8o+HcFeIUdsQsQc1cznoSeOmytE7uQBUz/BF/SJgjBgmAb6VrFUBdqAlAB+6QDy6DBtDKNFvq4kcsNQINx6T1Jr6YA/6TTA7BgiGidePR4hVMC5Hc+5+yZOXomcV6COPxdBK1qdpWTcSF1Ref9zejEFJYwcYsFOHdkqwdlDlk6W/vxrOQMtpha9bh367qczgq3cXdPE5yvGGuT3T1pQ1mySh08XiSLIgJbPaIN7zMhKgd+3G/BXt1QLjGR2JrWFRB4iu7Gebng5Nb4zB5irj1XqKv2Zx4EWhL1P+jSu4ZTRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/quhmMASiGQDOZQOLFqMz4GMkyRanzbD0FJL4tsntA=;
 b=iNm8vMWZmS4jXKMlvXfayeGrcap1/wXbZjtb4aD0REveA1iZuWe8lDvZFq7Y3b4KPNfXB7sRkFflmeW0A+Bxi3iN+SVr6G/+16KgbxrNj05WZXw2ywGb1ES+I5vUg3Sd/J3WXFsrZRmGmFJJn+A9zEAD4ZTo368EVy2es94lpt8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR0401MB3696.namprd04.prod.outlook.com (2603:10b6:803:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 10:38:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 10:38:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] bus: fsl-mc-msi: fix MSI descriptor mutex lock for
 msi_first_desc()
Thread-Topic: [PATCH v2] bus: fsl-mc-msi: fix MSI descriptor mutex lock for
 msi_first_desc()
Thread-Index: AQHYTkLZyTZGrgBEjUuE0crYEsKlAK0DqWwA
Date:   Wed, 27 Apr 2022 10:38:46 +0000
Message-ID: <20220427103846.hjnkfn5fpuqlzuap@shindev>
References: <20220412075636.755454-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220412075636.755454-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2166fe34-f782-4de4-498c-08da283a1c17
x-ms-traffictypediagnostic: SN4PR0401MB3696:EE_
x-microsoft-antispam-prvs: <SN4PR0401MB3696353162D15260043BB27BEDFA9@SN4PR0401MB3696.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZNVxd+ovuJDwO+1oDrX4AE+Giobp+ze9YtMn+LEaO8Bo9s9uaiLR1BuU5tq7j0YmPjWIVSSitTuPRt+Uz8p/FDj2lpKOAV8Eo34BkZmHNNwi2KK6x/ILeUHsC54WfzBCu2vPGlQbLBrqsiNH23zi7ow1x6xih4L5Yexsnq6hPc89QyddOWQyZv/xFAL2SAyaHEjrlcOpBWTJ8jQhuZtHUKYuqSeAuH+BEzoJJsLzYTm5qzMApOYtN/p7hlpiPXmzZdAeD5yXgJzyLrTzpDAmAVOQaWznUwSWDCUqIUrARWAQ2PuU2gRLI7DQwf6XpDMwNgWAzcy2f7bg11K8/loSFNA3fxqGPcvM2eYAQq/wZA0ETi6y6cxuv8cI8agfWpjlftRZ+a7aHsEq4nxwS/XpL1+pXT4ZzvsmHKGh29kKXpwfjXdlvHdCb7pm5fhzEiljDh/fA/sp8jbVnGmyAhRldBTbf6nVSFs147Lv0Gd8dODifV9gHmgAPsajcZ3xgGS15Jec9SMhX31NS0GMShmQVgUYP0mnyTZzlp5ud01OSgkulEcau+YnObGnyxPnfb2c9/DBvWBPT0PuvYvIEcTAM8ztqG8aYNgaebl7xS1ulB4Ie0LmTRM9MXk59/HdWtbJDwj6AWfZKUmVOH7HMZ2A66lxmUzoREcdr+lnvt4S/RTpN44cX/39WFZcLgsVHCWUi5ORsOC3Tt9VwTWUHv88Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(44832011)(33716001)(76116006)(38100700002)(71200400001)(38070700005)(5660300002)(4326008)(66946007)(66556008)(66476007)(64756008)(8936002)(8676002)(66446008)(508600001)(91956017)(122000001)(9686003)(6486002)(316002)(6512007)(83380400001)(26005)(86362001)(2906002)(82960400001)(4744005)(6506007)(54906003)(110136005)(1076003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IEV5StX3CPlIkwDyGQrHQmt+GlNNyeBGIWkU8IUWTIUu5iSfjvy3vV/OGmpw?=
 =?us-ascii?Q?z3LygV1kCckVAxdGlehzfQOPSDKbGE98JfcOsgs/N5k/U8azEBntcb1KcNBs?=
 =?us-ascii?Q?Uk2IVrEeFv6ebB+++dkmuEp62gJmxJtGLGBHuNipcGL58UqavgGjqPZ1Hez2?=
 =?us-ascii?Q?i08Wo3mG/QFsURXJPsXcoRYghdhI0L4pKPkNWdGLxhMklqnMtVjEqnoK95kA?=
 =?us-ascii?Q?iSKthxMmhQ6Oc+nv3Y0haiufCAtnr7GnuSHKfgTjFr3d3S1kX9xt1t+iGJdr?=
 =?us-ascii?Q?ftIcxDEbVhWdnqeP8LqCaQvz/rjnTzxQNs8QoX5RX6ta7h/naJcn0DIM4nuw?=
 =?us-ascii?Q?IW8De217nBQV4B2RN3aFsmp/uGEBFCB8G/idxQC6yXHBatxQdAxkIpmOL8RO?=
 =?us-ascii?Q?PuMalseJpv2uPTwnzlNcq1gI1HxGxhnlL2147MjXcIGN3TpHL0nVied492LL?=
 =?us-ascii?Q?VCgLMlQnw1jkcz9ZXohQt4pkdn0UAfCgXBCjykwFCt9+/PgRyu4X+t9pMU6c?=
 =?us-ascii?Q?sugmorTb30bB8SAN0+rb3YYveVovjOnclZC1lTTYZ29FWkT7xbiWdAY2oX88?=
 =?us-ascii?Q?Mv42eY7JSYS4vmkanW+FKvUr1hoQpa8aPhare3mr/m0O52k5DGlZC6s7NZof?=
 =?us-ascii?Q?LbS9S+9Ven/wOhyRWJEeiDEvsvocyJSfArUf2alyQAOVzYkA876Q50KutAlT?=
 =?us-ascii?Q?RmmQmjWWwmttKiQDgWr6eF12fG7dlT/rzDulLiOQfy0bgECdy965bcPzlZqU?=
 =?us-ascii?Q?m3hNtxXHHyeADrH13LAXRfK/ervHmk7tJDO6bePsC+bBoiUTvDDU8xAoKEVO?=
 =?us-ascii?Q?nbt6UJET5iDHcp39teiheKVe6sl3gqan4j4cdRYZ0Z7MPcDZ4EEzNi1NIymh?=
 =?us-ascii?Q?Lm+Iov5qEIT4RSUbRyCBLtbUPMIe83yLwZ260qDhApGpDLkGK6ynkaxrIxLO?=
 =?us-ascii?Q?iU3MFkottns8ISGDHDVASCuEoUvWrC2co+rx126Ngh64aIcnVO4hFr5EIxSN?=
 =?us-ascii?Q?ur2zRFGcVtfDXbFlef1UZHl0BCh5G9d0pYHWNhu9zt3INh9mI7JEyy7Di3rm?=
 =?us-ascii?Q?uvr1bQodtUvFsVypMxPcWyhUUKXVxhBUaHDk8QViPE6wPUoEx3Uznt1HEYsi?=
 =?us-ascii?Q?t1JmqUQMImboXCVIxq4+5/q4eKK0IThThPzRk/fONlGF28KXphmvDbCEuw/N?=
 =?us-ascii?Q?T5csuLKetzpRCIrqnf7HwJDhjaSkWnHi85g8K5KVzksZtVKv2r1oKnnAhFG7?=
 =?us-ascii?Q?3Yrwxac83+Ag3w5dSO15ee9Lfri3x0x2W1JBDpdgM43aMjHqHkzy4+GxX48k?=
 =?us-ascii?Q?YyN83N1xkwu/2+OQyY1/nFTflWNvHceS4OwFINXVufJssB7jeMzu3QFdIHmh?=
 =?us-ascii?Q?63WPzLvNKOy7Zlykf4Z0byE7CmzjH6LhCTDmsmDmCt6zhybjvq72DVYNLs+N?=
 =?us-ascii?Q?G4U2ICXk8gbYbjfPi1oy7qCAfCQDMWmb8UeRcOBq73NgcMQNsM0s3KOrvKHL?=
 =?us-ascii?Q?m9Mz07mQrKFm1TPYNbABkQDcDk4qRLDyfCry27+DIoEkTIfto3jF6SMmwKjM?=
 =?us-ascii?Q?NST0ZG6BGyW9WYeoe7vWxbf91WQTTx+YVUKTA5KHecq4G3WL65IT5kYO50Fz?=
 =?us-ascii?Q?qYbrW8OJcT6N47vd85Jcc+6Bm1Rt22vtha2UkzLxehBGekP1KkMHJIujxorn?=
 =?us-ascii?Q?3MZwOCC/JniJNqY5XYAYC1N4xW8FLIZltw6dM8HyS9hkL1NyxSQ9WQQ11Xvn?=
 =?us-ascii?Q?NPdmE8Ny7h2tyZJ1o1OSjHnv79oDZwIub3yVEkFemQQo5e9XzEQ8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C2550650578DC4697607F1DE135A973@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2166fe34-f782-4de4-498c-08da283a1c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 10:38:47.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5GWfutzWOEtwKJEu938qSmt/yMb4E90+D0HobUJlinX8mCTLOgz0EeuH6rTufgtkke9ewRMoJmS0wqYnUDz30XUd5P1mLcCrBus+97I2Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3696
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 12, 2022 / 16:56, Shin'ichiro Kawasaki wrote:
> Commit e8604b1447b4 ("bus: fsl-mc-msi: Simplify MSI descriptor
> handling") introduced a call to the helper function msi_first_desc(),
> which needs MSI descriptor mutex lock before call. However, the required
> mutex lock was not added. This resulted in lockdep assert WARNING [1].
> Fix this by adding the mutex lock and unlock around the function call.

This is a gentle reminder. Comments or merge to upstream will be appreciate=
d.

--=20
Best Regards,
Shin'ichiro Kawasaki=
