Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6A4C3E84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiBYGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiBYGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:41:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8B27026D;
        Thu, 24 Feb 2022 22:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+biWWavF2xCckYRjOEYf23UcEVt225R60jfJISz8kuqcWN2v0BJowITn69aV9+18G6lVy3iK21bmr/hIVGFcL9Up8xyUn5lLsfn1nLVdtfsgcdNR7Z7zo1cN5bx17dyxWUe+SDhrs/zEt6ANRE48BwIVECGJdai/RKYCFVruqJkJ94NBba8Tev1Ffopez2DGTJ1fMZZiciX/0wpwE+wgc6IQbQMKhnQfeFhQ2b6R09ttGtFMHPaZNIN3PFn3LSd729GDddaH4jxuTTJz1t/tgKDWgDhCjHxFvziRQ82VOlz9iJ37aT+SCQ/W5hjwkkv/WY06GgWFiu9xnSGHvEwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqlOOxKvvTChI7USl2u6Sgb9zJlqKRrRAx02r0T9URI=;
 b=BARFCbA6ctSnkx1cEk3MWXG+VuhlbzNtjocQhWI/Rk0bUrYaUAriWpmLeqaUSxAaD5YhSN2pQVtzh0Kt7jJTVIgkSkZgmWQcoXkg2fDj8fXienbGzND+UCDi/fnGtyXkzxGKMe226JCz1e5RB4kvIieNrcQmdadr7HuVkP1UC4PKn7uvRGgK+G7cuMmugBqaYCZgMs6NAHMu7jctjHFDCuugKrrU3y3cip2Gr7/A+qAACDWSga3RtQE0LGB3PTryiJbi5pgHIDg5wUvR++pohNIgxoy2rlvp2ProNcUewKCcdTG0s1qpYvvHQfOwI99/GrcZ6XhtfX/1wPtLUn/1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqlOOxKvvTChI7USl2u6Sgb9zJlqKRrRAx02r0T9URI=;
 b=HkIyS0rtWlohSgyviZxSTDJUZ/vEv0egZYw1nwu/73PjoDO4VTEnKnPZEPoj/Z+jHw9fTTkvNk1gVDQeY6+4aoZSCMTInjO1dIj1EGYr1UAHjO+eBcXsuSc+mN6Y+gHzkiC6QnCNwfUFhRJsw21V1+MnU1nWPEdDAmDuSwpnNigZKdt3UcSNbtqn/4azulzqbFVaBPRyJj4JFhQqmr6EI0JmJxvbZs0RRPos1qBK9IjmKA/F97mk9hWOHJrPLPmxNUKoG2BEprui/dmaW96/mWPJVHAHnIklvTw7m8o1GELM8AFEmn/8xPEekXSUu1PtLVpnl6FTolmkX0XuobvYHA==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 06:40:53 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 06:40:53 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKgwFCgHVyOvH4ESDy/u/4+LZrKyjzGkAgAADKIU=
Date:   Fri, 25 Feb 2022 06:40:53 +0000
Message-ID: <CH0PR12MB5089EB28FAA6DF61F57F6D09AC3E9@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <Yhh19qsTsGRhsLWT@kroah.com>
In-Reply-To: <Yhh19qsTsGRhsLWT@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4600caaf-e313-1c88-4c9f-3ab00130298a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1535a804-ed0c-4bba-c12e-08d9f829c552
x-ms-traffictypediagnostic: DM6PR12MB2876:EE_
x-microsoft-antispam-prvs: <DM6PR12MB28767FE139119D36E93909F4AC3E9@DM6PR12MB2876.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgJtswULTuphIZAzlrcUe8zx0mKzZNb50VebVy0xlxrepi2LYIu2fpCMwQUCfs9sAH7pLU25lxHOC6VHIczCi6PgKJ+fi/EDC5ImdRZvujJQM6vPZj1og3XFfRM18QkrU95Cd9KsoxjeRXM2ZS8UFNJ+Qzg6rbcGxWObgsw2C296SLe095BpPkHWanYiqwk9CgLK9ggjGJFoSAjLIlPaC9184o25nr67hy6xtGphYfWjqFAN9ujgMo4YnCPvmOMkT140lc1ZGfS9TLnN9lnIzYZ8JC0J5J+DOPaQbVa8HDZuh7/dZ9EbIz4fhf45ki71Qx/RrJ7pGhuEvNa2q8I8mmNtSr3STmIn7Ns3xXwzfiv0+mMjy6gvNNVhpXjFLjVXHlmXrVntiXT88DGAsdspAmGGTb7fHIXmjhx4RqbkgQli1BU/2qpNg8ot/mtKHXocsR45iz1XEGDSjfTYjsiGi9baOxmZfx6+Y+ZrosVSRr190t7REqXXKLZH+SfUYdNlQOMHi6xwqGb+t12SQDpAPEYeDj+ZX81ZetLGCrQ0tLGJlSa0yTc457ibkCjxoLfP5egakTeR0nnTMzyav3DkVvu4cuGcmA4xnx2O2KuaQaB5GoJxRBenA71sjHhhT3BVtryyLRiGIKPvZ1e9lNEvs7gKTtSyIlimEo1z8yOfx78qF5glbdzpGlrbRv9r6KZywFK3f7CFpXhYwOw1plGCzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(9686003)(6916009)(316002)(91956017)(508600001)(71200400001)(76116006)(186003)(8676002)(66556008)(66946007)(64756008)(66446008)(86362001)(54906003)(6506007)(7696005)(122000001)(66476007)(53546011)(8936002)(38100700002)(4326008)(55016003)(52536014)(5660300002)(2906002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Dho7ol6l7KofMYqm2Y1vFXvtnGga4ecyj3CDQZfoHKC5sLomZN601bBb8?=
 =?iso-8859-1?Q?x0mvlj3qFg5NV/o84w4rdWhpMANMcaxeneciex6DO5SQhL7EZ+uJpavMVU?=
 =?iso-8859-1?Q?3IyNY7VsjP5w/z8h6CbhmKGQd887i/ky8FtEw6zDZtditpFovwM2poetWr?=
 =?iso-8859-1?Q?TwplkTuKGa7YAm/qDsqZgBp/oAf6/BwniCrhJ7YLg5zv+Iips31k4fdmmc?=
 =?iso-8859-1?Q?v7uolWKVhpn3ihJPAfg41l/IBKlVQyO4sHgrbqfgPCcWbcgs6o59iU44Te?=
 =?iso-8859-1?Q?pMUweTUqYiA19zBF+qHVKUEE0S2KtVGV7GngHYmMGjN/zhQHdBc600W51V?=
 =?iso-8859-1?Q?GcfljM8rGW0rDbth+7XKxALY9B+gAinKSKAKoBVexPFxoMkZKSjPzMWmXr?=
 =?iso-8859-1?Q?jPQRk+yoeTl3Vv+4xW0saLygTQ6V5ay2/sxC3WC0dAeqKgCYqKYrGeZ8vB?=
 =?iso-8859-1?Q?FQ5b7IUjzivRkbnVtt1orFlPLZuvXvoY8EsF90sfzHMlHvsw5Nql8JbBCw?=
 =?iso-8859-1?Q?0qTLPp2vk12ShhR8tPpNbtyKyCY5ZGM6jqph3LlcmwywXp+EEj5B4S9ToQ?=
 =?iso-8859-1?Q?0dnSpBXecD0aeV8UVUjkQbYbBOau5aKfxEHseFRnUTNbPdG9pOXumnQbVi?=
 =?iso-8859-1?Q?jUv6z1mdiVn8ECmsWmzlOjCTAQ16C0uDKiDajxw1iB7lqJ7BLs4HCxwVA2?=
 =?iso-8859-1?Q?D8xEqrnAA6Z6DtdpR3wwS4Dzahhqe6jMUMtkXU5de8p5fRDsifL/+vX7z2?=
 =?iso-8859-1?Q?6tqm4aRD6JFPuVbBWQejdaecqsgrBh5I1uoTGtzSw5bKb5AZtjRlK4+l3x?=
 =?iso-8859-1?Q?hPocOZq2XQrS/bhMbbhf/Mr7t9neRPGyjCaobANaXttsUCFv1OmPHi3rbw?=
 =?iso-8859-1?Q?q4yFGNHNpenM5JwHHCTELakBSCc48SKc0x7UA73LFNGTDuR/vt71z4G62d?=
 =?iso-8859-1?Q?anVxy/vTY+Vwb8MlGxYXP+V0Kb18xQFvmMGHT3PuvuowlHVxI6ZN3YeHZc?=
 =?iso-8859-1?Q?GH/jfY4y98giEngCirQ3l6j/UNmGFNz6+FVPe/2yPXA0VFT9wfwTWS+sto?=
 =?iso-8859-1?Q?I2sLN3OTqr4w+YsfAPYbbk30/BDbN8WMXk8SHh6LuOVXcukOsYbMMG/jaN?=
 =?iso-8859-1?Q?nX+jBdp2SEIFJ/xgeZoDWGBnxkSUPuSdl1qs7Fhd874vJQjV3M9r6JTG8z?=
 =?iso-8859-1?Q?CmroUFXOEHAlnveBym96f5OSLb0qb/hHEOuhuaoZWVqEMRXj5GHxFyEWYj?=
 =?iso-8859-1?Q?P73rCoDNMNiAqhJE2k0Sz1IBbW5QcvoQPQe68Auh8N+ij4rodbtVU1H79r?=
 =?iso-8859-1?Q?1FKxQ5VxIf7lgTeWqut1BFwq5wqGMZVHTUsS7gczTnhKIN2MjfTyBJFjTT?=
 =?iso-8859-1?Q?Z5S/P87DMOMzZGDtggxWh+z26z398SBdIc0aEb2m3Ll+HoQNO8IaM5M+Px?=
 =?iso-8859-1?Q?c4wt4KXPlz9RFK8v3FbkfTjxibjmhQ5WlNwlypS5MjoWIj9/pDmkj9AmNK?=
 =?iso-8859-1?Q?unnyivbFz1kFzQzhScq91ZbhfoXRXRNAg+qv5SvsViFxOuRPoyz+2aV/Ng?=
 =?iso-8859-1?Q?kbBqJvFgBXV3nRDod1YsjOmmPl6oaLhcirbs4W3MgKpEfa8ECjBUpar8B1?=
 =?iso-8859-1?Q?yl0t/2xPG/Xjy3z3a9i+MVCwlTxr/2WUqtkiJJiVU8mdsM63EBa4Es7w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535a804-ed0c-4bba-c12e-08d9f829c552
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 06:40:53.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZetP92khJ6itHBGboLPB1UOUFnvSO+ftRHtH8DNohIrbgyJ247NmGJjpbgN0QKYtfO8nalGDR7UBi5lV5l52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes side effect from below change. =0A=
=0A=
commit a231ec41e6f6433daf4c693f169f6c5cfda8cb9d=0A=
Author: Mathias Nyman <mathias.nyman@linux.intel.com>=0A=
Date:   Fri Dec 7 16:19:35 2018 +0200=0A=
=0A=
    xhci: refactor U0 link state handling in get_port_status=0A=
=0A=
    Move U0 link state handing to USB3 and USB2 specific functions=0A=
=0A=
    Note that=0A=
    bus_state->resuming_ports:=0A=
    bus_state->resume_done[]:=0A=
    are only used for USB2, and don't need to cleared for USB3 ports=0A=
=0A=
    No functional changes=0A=
=0A=
    Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>=0A=
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
=0A=
--nvpublic=0A=
________________________________________=0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
Sent: Friday, February 25, 2022 2:23 PM=0A=
To: Henry Lin=0A=
Cc: mathias.nyman@intel.com; linux-usb@vger.kernel.org; linux-kernel@vger.k=
ernel.org=0A=
Subject: Re: [PATCH] xhci: fix runtime PM imbalance in USB2 resume=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
On Fri, Feb 25, 2022 at 01:53:11PM +0800, Henry Lin wrote:=0A=
> USB2 resume starts with usb_hcd_start_port_resume() in port status=0A=
> change handling for RESUME link state. usb_hcd_end_port_resume() call is=
=0A=
> needed to keep runtime PM balance.=0A=
>=0A=
> Signed-off-by: Henry Lin <henryl@nvidia.com>=0A=
> ---=0A=
>  drivers/usb/host/xhci-hub.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
=0A=
What commit does this fix?=0A=
