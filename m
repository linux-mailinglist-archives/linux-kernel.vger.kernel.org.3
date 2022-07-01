Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B05562BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGAGiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiGAGis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:38:48 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 23:38:46 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CDD220C6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656657528; x=1688193528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x/qNyfee8z6RUjiy1govKqgoC7dkSVzOgmRt97PfTHQ=;
  b=oqEGQDDlMD8SRkd1wedI3y7gvwEDrh9AWW05fqlOH7pwPN/e+FkI0j8O
   WriUaZomXk+t62ApjsHisg+KcPtkIu3KrMxQwyZ4a3DmtrVO8Qpr4OooV
   NRmXg7rUaHcl2kLTwOt+XhkJeZifvyNOsuyuUVqiMww01C80QjG1S6In6
   2wX7La1xsq4phQYBjsaUMTSG8dOMr8JaAtVCgAPT/+qY8PqAIOLSmCuYk
   IHD8sLJR5OhHVsyVWCcj7+XduUSqeZ/cawaTzyuRke5nDmd+fVKEwsi31
   BV+eEcIZor/ZwOWGO14D71xiWSKlBOeOFWEqAUjSmB+e1oNQLP2rBTnf9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59339706"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59339706"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:37:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhccgG0Coy91/SRX3COFuG8rTuQ2WTTNWX/SB0QBEBIwAoQOG9E5UBRkZZgIiUjcsUEIZOCh3piUJvlGFAHHih+EQMQjDh+YoWfTDEbpiwlw57DcXc6NpW0Hy5Eu0GFNIFvcck4HY81/u2HbESQ6jzVttQUituGpd/5PUSxGACqLo7EKHKjzNVIkjAZKwrt0+YOONwTFQdOGLVW8nUXyEqlCeGCTKf9L2U7k9s9VIQnjxMa8IExXZzHXPEWhL8/1zc2hPwbuOoemecv6nvlb/IDGGSa94OXw++yIJE9YqdyTuBGN6b8j4SgwcVT5E05OAujbqe4f59C/eK25yVf0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiFJx6MC+e6cLnxK4S3yPEfwTqgjibF5pAUqULlqUIg=;
 b=RoAzkdG+yPfQ9ygjriWNCnBRJftrk5DuFJrCY/f8cmoNW6VHTROL9OnPrJ1b6lDjWnMAMuSxXW94wY5MR6xw/Ub4uQc+t0kU9TDfXzwhvW/iLL46KgA3VTNxMipHQ0qpPEeOdkWc53GsWd1ktFv/DhEe3Q9wnGBSQ2G5sFRNkQFNBxkS/gmVvzZBTU5JiYXwDg6iyuKnRvr7G/vAtqXf2M89pdimWp++CN+z7Xknt6L/azuqjx4wI9h+gqNqPYdgydmx9InIl5CRN5HmS+1SOX6IhN4s+MjG5w5QYgOjuxQaOXDvRxOlgGpS+Gj5oNPNISlqHUy3mlT5C8rR28ZhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiFJx6MC+e6cLnxK4S3yPEfwTqgjibF5pAUqULlqUIg=;
 b=Fv8qPu9RkeFSdSOOpaaCQbjGshltAeFD2CjiSXj45a+62GFgoY9lJoF9ivWm3U/EvcoJm3SwxDCqgSbmBgf80MwvXZ6YTGdUMY1ekFkaJvZe2dcCeaRDDdPxIQktpldYCiOKc3/SBypMsgqCztN87D5H06++8l2kr4v7bTvbaDE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSAPR01MB4129.jpnprd01.prod.outlook.com (2603:1096:604:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:37:34 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cd21:d921:e755:ef70]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cd21:d921:e755:ef70%9]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:37:34 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
Subject: RE: [PATCH v5 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
Thread-Topic: [PATCH v5 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
Thread-Index: AQHYhle68z3EpKIpt0Wg+v62Ec3kEK1mDBuAgAA4AgCAAtgaMA==
Date:   Fri, 1 Jul 2022 06:37:33 +0000
Message-ID: <TYAPR01MB63305B2B5CECD651FCBF61348BBD9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220622164629.20795-1-james.morse@arm.com>
 <20220622164629.20795-5-james.morse@arm.com>
 <TYAPR01MB6330E0E18CF4A229B38511648BBB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <4ae1e6d4-89c9-ee6a-f74f-73fa84b406e5@arm.com>
In-Reply-To: <4ae1e6d4-89c9-ee6a-f74f-73fa84b406e5@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-01T06:33:18Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=55a806ab-e703-4f2d-9234-87a0596242c3;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de1cd09e-4b4e-4df3-dacb-08da5b2c2e4e
x-ms-traffictypediagnostic: OSAPR01MB4129:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+krR9AupGlzvi3GKRntrtserWFtf//4VwsCSLJ9Yg12xoebuM3Jadd09aa+LMozXRvY+cNLjLy0vZ7sQ8miVr7EEajivgycZBmp+kmuDUruNK3ewGL4qNuihKLd4p87gr24Ah5QFYD7rl4x6LYR19142waYnXoMlDVk+6ECBSmjBMzy2fToGRkYaW4xsWiajiE5ktUtku2k9EWe1pPY8xyr0oaRsHwi8BRPXubiesSNy/Ia2EFo3bh52TkIoIAwRbtLBALZ7vYzS5m5jm5Duwkh2PzBvZtN2ew0y6UdLRwt+m7ST2NFqyvfkc1kQMswEWVoGKwzw0tITMsWyVKZx9eu5SVDB2gMprsP94ioBdwciiPI086G+BN//BBfPTlT5QxueMIH7ir9lvzyJCCRQ2xgsPR20EXggOPbqPS1JevN/xfxxKgJe714HsjRLG+2HipTZJk+ORE2pDkVIxu0+JvURPCdjxMVYy5glf+QocOTCo3iLPfmGEVX661DQ7XKkTLLEO+2CZmfgd9mHTA5UF7jL1wkTN6xDJ75Mvk9B8VuwWNxoFv9gwDa5xs9rtQKkcC6qGwoCPC520/76fP5W++N3ci1bsWmhNOK9qqvDJuJa1ErfhAF9biOkIH+ueMItxwUsX4HRfhE7/gUmahXc9q/+NXW23DAh8M84PuMGo/VTmUikncPwgVfrq1DZimMWDUL1W8E7H1zueRSEs5uuFfNyUQDZ3Fwrw6SDQtUwRlGh40EeuvCd7/oZjQJHn6HUii3GwxUc2K9H9+DzRwvc1xnCfnW5g9sdixjxPsvAF4u/1dDum8xEJ9Q6coAbsQ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(26005)(53546011)(86362001)(110136005)(9686003)(85182001)(55016003)(38070700005)(2906002)(41300700001)(66556008)(316002)(66446008)(64756008)(66946007)(7696005)(38100700002)(6506007)(8676002)(66476007)(76116006)(54906003)(8936002)(52536014)(4326008)(122000001)(7416002)(5660300002)(186003)(33656002)(82960400001)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WXNVcGE3em1wRHVFU2xoclNTNUExTlNUQWQveExZdEEwc1pLd3hMaVo5?=
 =?iso-2022-jp?B?bTg0WkFYWVRwSnJHMmJXRlY2RlZwSEVwZ3A3c3FyaGNxUlNYY1FFOUY4?=
 =?iso-2022-jp?B?N2xoT3VXejlJQjhHVFBEaWpmcEMya1hYQndOTkdoY1RzQkRDNndZS2R5?=
 =?iso-2022-jp?B?SFFDZGhLeFAvRldtSWE0WWw3MDdkaTdvNVNJcXlZa1JrNjg4cVpGQURB?=
 =?iso-2022-jp?B?S1RDWXlSeXVIWVQrUjhIS1pIRlVVWnc3bDYxbVFNUWxvN2VrUDF6Rjdq?=
 =?iso-2022-jp?B?eXZaSlFYa1hJblFmWURDWTAxVDdtK3lpaW5ZeS9aQ1RyOWpSRUZheEJ6?=
 =?iso-2022-jp?B?R2wwaUVBMnkvcTlCQksybWZkZDNjSTNrdDdDbjMyWXU4NXlGVlVXeXVj?=
 =?iso-2022-jp?B?UHowQzdVd3FRVEIxa1pSQW1oUm5WcDNaempONTBVNjBwclFOUkVaVU1X?=
 =?iso-2022-jp?B?UnYzOURSM3RIUUl1bUt3UFF1NkRSTVIxanlZM3A5OW93dVh5ZzNSaUlP?=
 =?iso-2022-jp?B?anRrZ2YyT0w4aHkycXJQdEordC9DZHFuaVgrTEhQOVErTE1YV1Iwc1kw?=
 =?iso-2022-jp?B?VTRBQlhaOWd4aXJPY21UVzdkOWx4Yis4aWtuTHk0WktrMUh1SUZQcXNz?=
 =?iso-2022-jp?B?eEZ4UGpQL2ZiM3hPMmFiM1RZZUFrTFRkYjdKNWY3QVYzYjRWS1pjYTZL?=
 =?iso-2022-jp?B?anFTS3RUajgyL3ZzWEEvVjR4QlVZYXJKbW4xbkhLNStGUmF5a29SY3Mr?=
 =?iso-2022-jp?B?a2k5aXllMVNoSFNLdFg2cWt3YlBRWks3K0hlcFFKaHhlcjFzV0czclVC?=
 =?iso-2022-jp?B?anZGSGtRU1BodVJZN1lNcm5vMDlJZll6SnVCZXd4YXZpaTdwdzh1OW1h?=
 =?iso-2022-jp?B?TkZIT0NTdGJaTllscmU0NWl4aW9raE00LzczazNDMU5VSnlJSXVwa0VE?=
 =?iso-2022-jp?B?dGxJSGNmZGgzYWtYRWlkc1M4MExBejlZUnpYMkNYWHhLME9RdjQ0UFoz?=
 =?iso-2022-jp?B?ZE1Eb3c5RllXWGlRajA4R282NHpjTzBuYkxRZ3Uyc05HV0h5RmtjZ3E4?=
 =?iso-2022-jp?B?cHdhKytnVTI5YzAwTmtZUCs5eXRNcnM5clc4MXJGcXJiVmQyQVVkdnVp?=
 =?iso-2022-jp?B?VzVvT2VyOE1rSnNweTB1emlMb2ZMV2I3TmptSjNPM1drSXRaWlBDZGZY?=
 =?iso-2022-jp?B?dEs5em90TkxwSE5FWk9obEhlUjhzYko3SGhWaUdkSFBidy9SekZVVVl5?=
 =?iso-2022-jp?B?b1lGM092cVM5V3NFYVdJRnExalQ5RzQybWxXNzMvN3dldklTcG1ReUNl?=
 =?iso-2022-jp?B?dGFTVG5YczgxTjhUSllIQ0VBakdtTXQ0ZTJjZFNRektyWVRNdVMxNXpo?=
 =?iso-2022-jp?B?N3lqZDVhNWI2M1ZLdDhCdTBNdCtkNEF2OFhNckE3cXB0YVFZbmkwbzRP?=
 =?iso-2022-jp?B?ZTJuRkhUeVlRcmE5ZUdTc3k3alJlb1FTQzlhaE8rUXBJR1FNU0pmanU5?=
 =?iso-2022-jp?B?TEVoc1dqd0hUYXRYQmF3MUU1aVZQWjVEZ1BTNlZTRmlDWmxRbURtZWlq?=
 =?iso-2022-jp?B?MHNmbUkrOVVoUWlHd1BkZ0g0SzUwREVZUStzNmRPVi8vUUxaQVlBeWRo?=
 =?iso-2022-jp?B?eWRvT3pTcytCT082UTkvMkJrbktJTVVYaWtNSUR5b2dGVHFEWVk1RHdV?=
 =?iso-2022-jp?B?Tm1pUEpxZGlYQU9nOVJjSEQ5QVpMUW5EYm1hOEhrR2U0NkJiWmc5STRs?=
 =?iso-2022-jp?B?TnQvVkZMN0pTQ1dtem5rOEtmekhZbkc1cG9ZQ1c5RzBUaU5XMlh4V1Qw?=
 =?iso-2022-jp?B?MDdJb215bTh2cUdqSUpNcGxaQUFRdTZlUnVSc1BiRmFnTThkaysvajA4?=
 =?iso-2022-jp?B?endEQXpBR1pGMk5wdkhnVzRGSkQxeDdFM2VJN0g5VVVxVk5ycUU0RHRa?=
 =?iso-2022-jp?B?SEQxcmZONUtsSHhaTkxGQk1ydGZzcCswblhDUjNZS2dITmxJSGZkN2JX?=
 =?iso-2022-jp?B?Z3pITXF3L2d3NXBWTlVtUlhjMFZNSHFENi9STEFvSTl1dmVzSXQrVUNl?=
 =?iso-2022-jp?B?VVh1dnpKaENEbWZGaWlrQUFOYlZmcGxFcjNVUVdOeVY2KzVRaU9odjNZ?=
 =?iso-2022-jp?B?by9CUzZzY0NnZ2RaMU5XTzltaGVVWkxtUnhXeUNURUNuWkdvb0xrazNI?=
 =?iso-2022-jp?B?OHZFcEVzTkU0RVkvQkkwRGY2elhRR0htanNPb1AvQTh2ai8yYktiTU50?=
 =?iso-2022-jp?B?T1ZZZEIwOXMyM1lPYXE5VTd0bVcwVlhrRXdlSUZlTUhtd2t4cW9DSkt4?=
 =?iso-2022-jp?B?dkgwY0lRWmgwNGpWbHVNRXEyZ0I5WFNMa2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1cd09e-4b4e-4df3-dacb-08da5b2c2e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:37:33.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14xLP+VV3XFLw+EkOOdKj3FsFwRN23aYe3Gp/USopHtHq1YiIfdSE9h9u+f1bV3SngiFo4ktej55MQXfZ75sJjQ6AIgNUSj66BjH/FdDsQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4129
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

> On 29/06/2022 09:33, tan.shaopeng@fujitsu.com wrote:
> >> domain_add_cpu() and domain_remove_cpu() need to kfree() the child
> >> arrays that were allocated by domain_setup_ctrlval().
> >>
> >> As this memory is moved around, and new arrays are created, adjusting
> >> the error handling cleanup code becomes noisier.
> >>
> >> To simplify this, move all the kfree() calls into a domain_free() help=
er.
> >> This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
> >> unconditionally kfree() all the child arrays.
>=20
> >> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> >> b/arch/x86/kernel/cpu/resctrl/core.c
> >> index 25f30148478b..e37889f7a1a5 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/core.c
> >> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> >> @@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource
> >> *r, u32 *dc, u32 *dm)
> >>  	}
> >>  }
> >>
> >> +static void domain_free(struct rdt_hw_domain *hw_dom) {
> >> +	kfree(hw_dom->ctrl_val);
> >> +	kfree(hw_dom->mbps_val);
> >> +	kfree(hw_dom);
> >> +}
> >> +
> >>  static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_do=
main
> *d)  {
> >>  	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r); @@ -488,7
> >> +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >>  	rdt_domain_reconfigure_cdp(r);
> >>
> >>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> >> -		kfree(hw_dom);
> >> +		domain_free(hw_dom);
>=20
> > domain_free(hw_dom) is executed when fails allocated hw_dom->ctrl_val
> > by kmalloc_array() in domain_setup_ctrlval(r, d), but hw_dom->ctrl_val
> > is freed in domain_free(hw_dom).
> >
> > Also, hw_dom->mbps_val is not allocated at this time, but it is freed
> > in domain_free(hw_dom).
>=20
> Yes, this is deliberate. These cases end up doing:
> |	kfree(NULL);
> which is harmless. kfree() checks for a NULL argument and does nothing.
>=20
> The alternative would be to spread the cleanup all over the place, so it =
only calls
> kfree() on something that has been allocated - this would be more complex=
 and
> easier to miss something.

Thank you for explaining. I learned.

Best regards,
Shaopeng
