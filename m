Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF48529E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbiEQJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiEQJyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:54:54 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9914B31343;
        Tue, 17 May 2022 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652781293; x=1684317293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjdwZFDdFj0VdUcJ8DlUE5pA4fADB4mYqHDJBDDT0yU=;
  b=j/Af9Bwp4BWk5snhWS33KSNTiXUqJigycN7hwwfTp+ti5GYhKuZJX2ob
   0yel1KHzbCtxgRbX/zudrB5LNsgcVmrDslz8yZPd5Zur95jefKF6WeYcr
   FJKfNJFxq7V9RgM0eQlsu6zuWgyBRAT/gPmNIBBp6RY0gbGGC9v0jGvZ6
   woC326Y/QBYmhNoUMGW01RaU6EDVF14eAEYTOSLrdRMbnav+v7qDqSR2h
   jsyHfMhBVen17EUNWn3EKomxonF+jqGAG1asa5rgeDi12bL6V7H6V9qPQ
   Mlptp+dTZ1PAU672FhimM/zdB0n63NozhiS3EV2bZtBPLQ21xxXwmpVAo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="63856273"
X-IronPort-AV: E=Sophos;i="5.91,232,1647270000"; 
   d="scan'208";a="63856273"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 18:54:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEQL565kXnxGJ8KQU+MW6BfdzN5o5T6XbF5YiemjzcM1rP96SIXjGmxH4mHPSUizknjwta1IcMvUxkgcNyKTJo9C5Epg8sDxFDTUkv72pG6SUyechA87mkKnWU7MjSceYh4he7SlKPiqVN+m15r1OeSO9dRrERUaZJ5kzo3175cns5E+VLgv7kMgIGUcQDajP89Rg5VYHyB48FXC8kiOBjS88mSEjIOYJXQfqFqMdrIK/kEaTjcW936tQhru815sPasyHAlmlAkQ+rlIhNxwX08OyxGE61AE2byZBYTsz1qVfDXsqtS2VPrtSjN2hsiiA97aYw+Ukpjfne9Af0Twpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltIx7NwlEkYvxV4ogDfxJsnqbp2/U0+BMpm3L8hmtB4=;
 b=Ikx49giO+M7t3V6Kq5uoByg659QNiIraIdsbGsfw+ZPKRGfCrfHTkuRE3sIL6XXfLzZn059amOKoKePgMMegoorq+mtXLloI7K1cRCSto4yoUimJMucLj/Lz+7vV+CqANyG0MrkmfUPL+RmCkJK5oSCHjBUmGj8pnVpMTaTYor/EtGhB40v1U3SLHLYL6iNmWks+rzBL2K1VFXZwojq70LUWTGSPhkjExm/L686CqC58AgZfdlinzbQvoNcvM/lsrot/XbJq3ijhqyO6QE/KwIU0g8hitqmyrRUt0fDE5E6I3zT/yRCFEvOsDjsJXUU61AUUEyTCzeps7cRbBnLyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltIx7NwlEkYvxV4ogDfxJsnqbp2/U0+BMpm3L8hmtB4=;
 b=hjNhRyJk9dbaquorSKY596irp21Rdk5OQu9A4jCYwTv4JS/zVcOfLcckBQKHXoZLi0c9BuYBs0UX8avcw7w3k0n3no9O634TRZYQykgIX9Y/M7yIQeO9azbfLW72OxQ4elcyCCAu6TqegZrwdlM9c4J/Ip6gEUOeKMoCfY5aUSI=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TYAPR01MB5087.jpnprd01.prod.outlook.com (2603:1096:404:12f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 09:54:43 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892%8]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 09:54:43 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Topic: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Index: AQHYZP9hMqXNlfDlg0S66tEsssG4aK0ZPLSAgAmfR10=
Date:   Tue, 17 May 2022 09:54:43 +0000
Message-ID: <OSZPR01MB7050F695478F22E864E24411EBCE9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
 <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
 <Yntcn4esjJRS50Am@kroah.com>
In-Reply-To: <Yntcn4esjJRS50Am@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-05-17T09:54:43.408Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 17a99957-017a-8023-360d-ef95dd29bbfa
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472fe320-470f-4618-4f54-08da37eb44df
x-ms-traffictypediagnostic: TYAPR01MB5087:EE_
x-microsoft-antispam-prvs: <TYAPR01MB50873C9454C4B6AC75DFBA36EBCE9@TYAPR01MB5087.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQOSonZ50Hae/ALdmWRftb8bLzy6dCkpGX5n1deJzy+NiOqNsVRADrrb3e+8z3QpYavHYWuav3zQef6TdCwcKAe5fCIXkikWMOo6r8kepwd/f3LqsSpEEkanFexxyK3GnpJwHyCWZzmflOhqfIQxAjz7VWjlfL7ZKQKdKdmO4QdHjcHZAx2HMf/xeOuwroVFUvqIw+ZECGVeqdEMUlbCVoYzg6mei0oa5pMZwz7qnufbmvdE3WrNHZEQXO332f8N1WHtzplDCntlI3n+jSsgNT+UMwvzTAbHVwgQLJeOBucf269JeTJk4vUlrEkmzMmq+PZhcFk8golPXCG/dHz2w23cpFvfik0nr4kb/H3pIHQGoxd1gqOMnAuakr3p51rbv2xMiD6jmXLg1GseGiiBOito10z5CGCqoLSeDT0GysF3eE9kLXlpLbqM0DGFkPWj5kCgyxCzXf+WfNzmRlDFG+SgRQXZYlcgT9OYTxyxKcipDgV1PN0zWrIiemk9IC9vtwu/3k7AxOSljBdIYEDXrazfeVq39Z0/g2nflRPEleGncIsEWD71ByJyfcbav4Wmv8LwCr6TNnBZPAVUvEiy6mSxHI2NgNOfsiMg4n5zbxF5dcQSjasduFqJqWh3BjOVd1W1raCSdEUdGVYNKYcMIG8Hqr07zMjcI4N3hriK9u2zeiZ2vChxx7dVIRAz7ErglknMkOZIfeX++IGIIZT0kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(82960400001)(6916009)(2906002)(52536014)(71200400001)(55016003)(4326008)(33656002)(66556008)(64756008)(76116006)(54906003)(66446008)(66946007)(66476007)(7696005)(508600001)(9686003)(8676002)(122000001)(186003)(6506007)(86362001)(316002)(8936002)(26005)(4744005)(7416002)(5660300002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QXBvdTAydHkxRjNJS1pieHF1emxGRXRnSklhYWhTem1jdnl3QUhEczlC?=
 =?iso-2022-jp?B?UnA1RjJLY3MzTGg4dThYS0NoVGE3algvSVZWYisxR0ZVZk1SRDF1QkYw?=
 =?iso-2022-jp?B?STZiMHY0MGdFeFFqbUtZU3hUQjVJK0E5M1c3K0xFVld5V3Vma0t4NWNa?=
 =?iso-2022-jp?B?WnoyUm44REJEckRKZ2dNYWxJam9mZGlBTGRaODZzSFk1dUZCdkF3OUJ0?=
 =?iso-2022-jp?B?RnF2OHhya29KcjQzT1ZFdklGSU95ZUhDVWZyRSsrZFhQdXVEMTVKZi9v?=
 =?iso-2022-jp?B?akwzZVRYSmVHV2pHcENhbjR3Q25xTkdHaE9BVkhxQWVGcHVhK0x2OUpu?=
 =?iso-2022-jp?B?QVZVM1ZMNEJuNFJ3WkVIWDNWRmRrOHhvRmg5SFl5S2tjTEFDSFIxTEdq?=
 =?iso-2022-jp?B?d2Rpc01rNTMxVzhUMEdReW44ZTdnNXpCRlI5UmVzYzhMdUk5Y1hFWnF2?=
 =?iso-2022-jp?B?bmdhdjZTSjhVYnZ5a0VsblZ5UWRpeTZKZW9GT1VrVUlPVDlRYWN3WVh3?=
 =?iso-2022-jp?B?ZlEzT1dTUHJnYUhCcXRlSThybHNYSHlJeU1YRnN0Zkk4cTFiZDFsc2pv?=
 =?iso-2022-jp?B?RjFqZ2c5SUlReHp4Q3R2UU9LS0ZkQ3NsSWs3cWFqbUlBYXpuRFBWY2x5?=
 =?iso-2022-jp?B?UHJTZld6YTZoays3VklLT2VVK1A5QkpMMGhoNHc5WXlzdWNaOXZHSjBH?=
 =?iso-2022-jp?B?T0dOVUUxdHNZa3dqbDVDRm0yUmIrS1JjaUJmTTNkZ3ZSTXZLenRsMUdQ?=
 =?iso-2022-jp?B?a2RlTTdUSUxPOUovMGdzMUpqcjU5ajNwWklqQXpJM3hGUDhXbmdQclQ4?=
 =?iso-2022-jp?B?QzlDdndxTDA3TXpYbXJKSURORDJVZFlqU3RwTnJzbUxHdmpzdGE0K1Vw?=
 =?iso-2022-jp?B?OElGamtzTFRtZ2g4NFpGQTZDVHBEQ254RDQ2dDhBY3R0QXdJZGY5NjVa?=
 =?iso-2022-jp?B?OXkrOWt0TUNxZzQyR0t1WTRGV1dNRlZoVGUzZ3Z2cXR0NlQzRVNSVW1v?=
 =?iso-2022-jp?B?ayt6SmxqUTJCaHBFK0tnN0pVVmFjY2M5TE10K1JmRjVwRHRmM2VnSnhv?=
 =?iso-2022-jp?B?dGtNdnhvblJqY0pHMUw3STZCaGtYMCt4anI1WGRPR3pwRXo3UENvU21H?=
 =?iso-2022-jp?B?ajVnMW9XYWY5eVZDSkpQVk1OTmtkVGJyeEVrSUl1UkRhUkhDUlJ3U0xx?=
 =?iso-2022-jp?B?U2wvZVg1dEdmVEpGQlNtSm1SWkZIUkVwL0ZHYXA1MXl2empWRkg4anVu?=
 =?iso-2022-jp?B?V3lIb2MrTlJwQnhlbkFEeTlDTlBPdXlRSWRiWG1XTzZzcEJDS3l2bm1U?=
 =?iso-2022-jp?B?ZFZJd0lPYm8wcnpHZC96djRabDRPQ2VHcDlLNkNabVgwTmRKeTNxZXdZ?=
 =?iso-2022-jp?B?MlloOFBPLzVSM2dLVlJwR1QzWjU4UGlwMnZNMFo1em5YVjlEcnZibS9D?=
 =?iso-2022-jp?B?UDM1eVNZMXgxa1owTjRHeDg5alRQUVIxTEJaYi9WeUIxbkh0Sk9wMWgw?=
 =?iso-2022-jp?B?NWtvdkZicVdLOG5DbmNnSFhXcjM5UzZuUHlrNm8rczNaYzBTZ1A2Mms0?=
 =?iso-2022-jp?B?dHhCcm1CbHNQcU9CT0wrRG40ay9BUlhMSmZvYVhNK1RDZnUxTUM2aXUr?=
 =?iso-2022-jp?B?L0RTdmxaNTQ3OUNjVE9yZThpZzBnN2dKUXhLTnRISkpab2QxREFyeGVs?=
 =?iso-2022-jp?B?Y0RpcmNIa1d1VXpsMno3Z1o4bm1oeEl2MGdJbWtBRkRDMi9RZzRxSE5B?=
 =?iso-2022-jp?B?NkpkcEp3a1Vsb2ZBZzNKdVVkWFQ3QmdiSVdabytlMGlKYlZoc1J6Q1lk?=
 =?iso-2022-jp?B?VjhsZGo4WTZCOUc4ZVFDRVRiSUJtNjJ2aTRYVUZhYkdiNmN1bzIwYWtZ?=
 =?iso-2022-jp?B?UFgwWm94QnlIbGIvdU4zcHl5dzhldlZrT0VwRG1lQTRzeEJkNDg3cTlx?=
 =?iso-2022-jp?B?RkJuaGVVbU5GZU1IY3VDSHhzVVBmWFU4ckVoNmNlajVmQVNodi9PaGwz?=
 =?iso-2022-jp?B?a3FLSisva0hudG1DZDRRU0p2NVBBbllCWmtUOU5VYnVwWWIxZk1ZUmhB?=
 =?iso-2022-jp?B?ZVJXVnpLR1pjVkJQNUFFOGpPZDlPYTVSc0RHWGxxRGhvZVdzVmhqSkxn?=
 =?iso-2022-jp?B?a0ptbExvZytGUGVRaWZkTG5jZDd5bXEwaXRFSFg4bXdzd3dpVWxlQm5N?=
 =?iso-2022-jp?B?b1FvSWswY09lYnZqdS96UjlSV2YvbGVTa25CK0Q1RnllVEpFUkZvTHlU?=
 =?iso-2022-jp?B?TUJ3RHN3V1hleGNLU0JOOC9mUWpPZjd1eDVva2NDdUlvaGxLWjNoVWcx?=
 =?iso-2022-jp?B?a0xFTzdQYkVVN09TOUFkeVlzZkpTV2UxQ1JSeEVuV2g3ZFZKa0xVSHA1?=
 =?iso-2022-jp?B?bjFKWmJMMlMwZHM4TXBNeVNxZVk5L2RUWnJna095NzJjcDdyZWlTSlMw?=
 =?iso-2022-jp?B?cWlJS00yb21SbklFSWl1Y25ZUlRaMldVcEVJN0x3SzA3QStTRFJBdlJD?=
 =?iso-2022-jp?B?L3p6ajlNQXRCdmZpYmcvbWZway9QWmN3VXpSOE5lc1I5T2c3OHJ2aDAr?=
 =?iso-2022-jp?B?REVCd09DZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472fe320-470f-4618-4f54-08da37eb44df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 09:54:43.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIb4g94LcTbxDERvAyC/tsB2BFeEaLQJly2UckfDfFYdovkVAexPNqXSskLEb0a8MMJmierqq2ykq98/brjuWYhwyVa+Q8IFEIc0TO0wo98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5087
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,=0A=
=0A=
=0A=
> > +obj-y				+=3D fujitsu/=0A=
> =0A=
> Why a sub directory for just one .c file?=0A=
=0A=
As Arnd mentioned, I placed the sub directory following the convention=0A=
of drivers/soc.=0A=
=0A=
=0A=
> > +	help=0A=
> > +	  Say Y here if you want to enable diag interrupt on Fujitsu A64FX.=
=0A=
> > +=0A=
> > +	  If unsure, say N.=0A=
> =0A=
> You need to provide more information about what this driver does and what=
 it is=0A=
> here.=0A=
=0A=
OK, I will add a description.=0A=
=0A=
=0A=
Thank you.=0A=
Hitomi Hasegawa=
