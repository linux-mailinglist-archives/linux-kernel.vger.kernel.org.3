Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317ED521E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbiEJPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbiEJPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:30:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1CFB87A;
        Tue, 10 May 2022 08:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8OtjMsxg+tnfP+mzzP55Q8WOtTHMaoyGXelH0cjtG1eq/8LuA5manJRrR7TzJg/RDE/Hzk3cjZGXOjTUqdd4g+dcJVkYxmjH6I2MUAQDxcUDn5iit4+2C5QtnyeOT36SbMa2lMQUQz1ucWwMy87orqgxXV2RlyhaTMIovHrNY1Jnl7igUlid2Js5FG+PXJHHfcM7Gw9xH6U3OcntyKXKwPsQZoU3h9T9Ekn4s3hB+mOPd7ZvvmY94BCIofK8eEN4ol10wnwpoECa2AzDrhCXYZY9crE+0OUwPhci32Ysux8Hm+oGpYzNYIKOLEjMlMXS0zw2T7Pivc4775HzeKxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Sxa4LaicTMj3gtPb8VXdm4cnxuROtXM7gWdPiw7PI=;
 b=BwB4X0xwgjsDA5l/GHvIHo/32YIWfnO2LW/AA8nXBVQHSUkuQUh9SkDlwNDvOfBsmdtJgo/WlS1yKknCS0FD8pAmfYph8LjTo03VNoy8YgAObqlZ1osp4kqpV9lFbv/m1kt4UbUo+ZUsgjwNtr59vzJarrAsuSwRDcI7wP/7491kbsShk+eeyfuy3SgQHhmReN35b+MgKlNCObNnL2apJp6dnQJb6+0eAEcssoMOH+XOo2TW4O5h9lRTqYLMLzpEZDpSHAN24f13wTMi+Zc6keEVnaAqNW4M3fVpsg6Wa0SezmBuccTCqc9ylgbHj4kFQBy0iclcfHmbEETHlW+wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Sxa4LaicTMj3gtPb8VXdm4cnxuROtXM7gWdPiw7PI=;
 b=NaWGb9IFoh1G3YW2hEbO0RO+7d2T50cTYirZ+S8oLEaZ+9g6a+naSdney8G/q2ENnx8YsZcI+ZgAk8lnqqt7JYKE3njBW/NGorZuItT+vUOEepZn86qATxjenLEmHBjnemGbn6mSZ0eIAD4yXQKi2OuZF9OMDIpVNUX3VF7J4yw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB2518.namprd12.prod.outlook.com (2603:10b6:4:b0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 15:22:46 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:22:46 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "erhard_f@mailbox.org" <erhard_f@mailbox.org>
Subject: RE: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Thread-Topic: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Thread-Index: AQHYY6+CumXwSyvUc0i7ZZsU2I7mLK0YMjcAgAAARLCAAAJ1AIAABvXQ
Date:   Tue, 10 May 2022 15:22:45 +0000
Message-ID: <BL1PR12MB51578DDE47DBC47E4ECC04EAE2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220509141716.1270-1-mario.limonciello@amd.com>
 <20220510144656.nxbayvxdfcia3ykm@bogus>
 <BL1PR12MB5157994820103C599B3E2565E2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220510145640.xx2b3umlrylorxgs@bogus>
In-Reply-To: <20220510145640.xx2b3umlrylorxgs@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-10T15:21:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=52ef3f0d-cf5f-47a6-a276-91574595c6bf;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-10T15:22:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ba5e1d82-c034-4d99-aa69-1ec9453c957d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce0e25c5-3510-47c7-458b-08da3298ef6f
x-ms-traffictypediagnostic: DM5PR12MB2518:EE_
x-microsoft-antispam-prvs: <DM5PR12MB25187A7BE1AE6485C3D86F9EE2C99@DM5PR12MB2518.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRK+LxFJnmUZ73JLHEx3NoCocJ5BucyJmAWmmmFMGxhvtXlW1p5anhCtwye7NCPYkXisZ8bTZRIOyZtj9JXhUACcHOO5OofVRLRIeI2vkMPd2OSvDGR3m6lwW9vRstwbqDch2ccT1QJzbcSxwhc3IpvE/OhfzBcSzP5ZTBoUtLwbHDTXYhJFFHwsHAouNWSFUOg/EAEJmZAd9ft2jIA6PGGspmnDUvMML5+fp2UNqZYmn080W+SLZ9//Tol8+2o8ulYt9XCUgXAVBSCGvYb3Rvnpn2HXXfT56BcMD+WEBkRzFXZPrlCajwCCIVJp5dlhb/n9izR6QU5vuYwtE/6vVzQOzCz83sPjmNRJrvHkAZpI4mJw9l6qQXVk3J08ho80xH2OACqvtwxsX0qcDvtQnwQJQlcwu/olIsp5IP2bOrFYKkmHO87i8hq4ns67/wsyii1Xi1alVPyesBIELenRqs9vP6yoZ695+v/DbbpFKkNYjT2I3k5ioofDi6YynQwskWuI3CuT/TF3UeodXX04Qg134u75Km2hxcX+yVnVSpo/zPTc+UtZNCKh4c/JP3XPMY1oSDfyTIhEpleFMHVEoFfyjM3Wf5nWJ/b3RJbZjf30AHakv6YHFjLn9BKq6n11yfJw508C1nQ7Zx8KfI7w9Y/VVG/+fHeaHTLOxoh7x+AGjMyhttGSPty3ZJcqHCqF5ZTr5iKbuL0hLhcEeoi8gu36BiFCcdZ/GgzntyWZF+hVS3mZn2fnWY33OvWf2xONSXD2KIwy1bvwklQAgZc5aHHc8pJIo4G+DWQcyxakjuH1di/Een5bfHFpiJBMl/Szs0eKrQZRDp2GYuYLtpJ3VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(33656002)(83380400001)(7696005)(15650500001)(26005)(2906002)(55016003)(5660300002)(8936002)(38070700005)(9686003)(38100700002)(966005)(508600001)(122000001)(86362001)(45080400002)(71200400001)(66446008)(66476007)(64756008)(76116006)(66556008)(6916009)(66946007)(54906003)(8676002)(4326008)(52536014)(316002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kBElq87jh7TAay5Rx+srscXoaSAmDmbaouAiCcnHjN5/0FqhIRbLBiE/RLnF?=
 =?us-ascii?Q?1JBoYgPEt2ZBEZltY16DJRSjCC7gbHPyX5vyfLwiTnh09H2VIg2xZsN1+qAI?=
 =?us-ascii?Q?2SiExwFhWpeFPbMrfbE/pF1m+vmmhZ/U3mwjXIwtUObeqG0K7MK3jDZYlizg?=
 =?us-ascii?Q?0LBhl1Qo0iFheQH/NIv7wgJRWkxyRNtiT7eoKxHiSA26YkWKGOK4oCmXFh7Y?=
 =?us-ascii?Q?3T8QWoKo+Hke/KdBDz1KosMR29Km0s6g/t7mIpnhWttH+9sck802eJBv0avs?=
 =?us-ascii?Q?qvy060Xe4VnRutVByMXOPfEW81FkMsqHmseOQPZ/kxf2lu1dyW/4GmzWlwbH?=
 =?us-ascii?Q?cLLnguUSERsahlfUkrGqJqyGeCNkkoAf5iXv7Z5Sm4kMVIH1iL+7X138Z/FD?=
 =?us-ascii?Q?9o8atbAOaC+WYqky7yTnYDi/sInbfn+RMtmE2l4tsQKMBI9gj34F75/Pf1U0?=
 =?us-ascii?Q?4Lbewa3SJHQ7Vm7oZwJQQmvu3eX6ZaiER419hiDXFU/GUmmma3QYGMqnWQRv?=
 =?us-ascii?Q?0WEcIiNxVlKzT4dWOrepOIh7F4lia6iVGonAlDniKuZd2JCcUn/qB7wc81mS?=
 =?us-ascii?Q?j46bhyhamhatbnVvBVfL78E+GxgCej6o8qQM2Eao1iaCnY0kM0exYXVqeYyu?=
 =?us-ascii?Q?sfo0xhpIhaBI6djcAcc7q/+LMXbxUu5jHaaMC6Fd69rLRF+FHim/Gy5kP+lU?=
 =?us-ascii?Q?7ojz9D1ShM2A+CLWKcreZttu8LtbojcgtAQTNtfKiqKlmUaIeIkNzh7Sj82o?=
 =?us-ascii?Q?Jq+Pw5OPO4ZqqSVhC1Z3EoOrr3HTCJgaC3WIHhDmTSSLGbQkLTa2/6jmmKWW?=
 =?us-ascii?Q?zqTIRESEjQcxGHK0GkgDg+d8GWxeH9D94EeGPGnvTsR7vvMNWibSA2NIwcXo?=
 =?us-ascii?Q?gc6t6CCP/3On/DWMTCG8/kHiiTENuMdCyiSCctwwQkGOf5qbi/xho9e1q68G?=
 =?us-ascii?Q?np8azfW8gjViWodSx8HTVjAqyOWS7/7OIJJuyT2867rJS037PEYUeFW9Fbn9?=
 =?us-ascii?Q?Ci1LpFdeWj+Z+rOn+2/hMzozXyFcxjdbhWtjqZyQz2k6wKK6eOQNCdtBj5lC?=
 =?us-ascii?Q?rYl1gHIxrXqUYLCJTMHPHk6CEyggRmvd1N5ScG8wKNOBglzsCnjyEEo6rKMm?=
 =?us-ascii?Q?FQq3FbCKaX4WKVwNK+1X+djOFMINu5QjrEuOEYKaviZTvGUQIV7+LzgYUbok?=
 =?us-ascii?Q?iVPZy0XI3IKAP9kB4qbrvkuqFxvWb/M9GMjSyjdivDcIJlHvWO0LNM/Mbmap?=
 =?us-ascii?Q?LYNxBHSgKhs7KVTlM6r6iKYXEJePQMSFHD3L3RMql+DrScnmvyUJV5B7aL3p?=
 =?us-ascii?Q?YoKjGlU3Dq03UACF4guyErTzHo1rx3qspN8SpnV3LfalWNh9RqMiowAMEQBF?=
 =?us-ascii?Q?1YpplZ9+t3IHtHdwthgM2ZCZcMiz1jDNBKftIqImDHVPG+zURAAFRoICoB+C?=
 =?us-ascii?Q?EHfX0GtD82f78EbbqmLkXXA5uvOP27DlQGgauKRTyErUVTI5Vq3mVLGKHr+J?=
 =?us-ascii?Q?e6PoFNKFkKYL+A/lcMC8tOW/dKXWZyLH6DOs50zCNkbeBHjl/5LpYpG8V2d1?=
 =?us-ascii?Q?15YKNOs4SUG1lacT1DWizoa7/65vciMdV3dpbG/sOtdnRH4Cn2GqTPX43sn3?=
 =?us-ascii?Q?Ojix+FgZ/wH6WJ2XZz9/RSuxGE4dITaNosxTKW7GYeeb/HXDlrz+9O2/HGRT?=
 =?us-ascii?Q?S+nwM6uGS5n5w+9JAI5qJe6v2aFCtihqsKcSB91aBPH5v3eOcUuLG+gOFpcI?=
 =?us-ascii?Q?BTd8S4b93A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0e25c5-3510-47c7-458b-08da3298ef6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 15:22:45.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLU664pC5DGnzn15K1/w1y+fRVGxFZR0GYS62EvxB1cinN5vvyliZY99fW3Irb/4ItZBX9cvsR3AdzGkREi4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, May 10, 2022 09:57
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>; Sudeep Holla
> <sudeep.holla@arm.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; erhard_f@mailbox.org
> Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the addr=
ess
> sanitizer
>=20
> On Tue, May 10, 2022 at 02:49:12PM +0000, Limonciello, Mario wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Sudeep Holla <sudeep.holla@arm.com>
> > > Sent: Tuesday, May 10, 2022 09:47
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Jassi Brar <jassisinghbrar@gmail.com>; Sudeep Holla
> > > <sudeep.holla@arm.com>; linux-acpi@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the
> address
> > > sanitizer
> > >
> > > On Mon, May 09, 2022 at 09:17:16AM -0500, Mario Limonciello wrote:
> > > > `pcc_mailbox_probe` doesn't initialize all memory that has been
> allocated
> > > > before the first time that one of it's members `txdone_irq` may be
> > > > accessed.
> > > >
> > > > This leads to a an invalid load any time that this member is access=
ed:
> > > > [    2.429769] UBSAN: invalid-load in drivers/mailbox/pcc.c:684:22
> > > > [    2.430324] UBSAN: invalid-load in drivers/mailbox/mailbox.c:486=
:12
> > > > [    4.276782] UBSAN: invalid-load in drivers/acpi/cppc_acpi.c:314:=
45
> > > >
> > > > Link:
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> > >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215587&amp;data=3D05%7C01%7Cm
> > >
> ario.limonciello%40amd.com%7C2a6407ffdf5944577aee08da3293f29b%7C3dd
> > >
> 8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877908262860256%7CUn
> > >
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DlTXBFYCNnM
> > > Pt6KnL34rQWXT%2BZvdEwvmIdMWGI%2BfluCo%3D&amp;reserved=3D0
> > > > Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into
> > > pcc_mbox_probe")
> > >
> > > Thanks for catching and fixing this.
> > >
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > --
> > > Regards,
> > > Sudeep
> >
> > I'll take the credit for fixing, but I realized I forgot to add a link =
and
> attribution
> > to the original reporter.  Here are some more tags to add:
> >
>=20
> Ah OK. Not sure if the tools pick up the tags added like this. If not
> better to post a version with all tags added which makes it easy to apply=
.
> I see the reporter has tested it as well, so guess tested-by can be added
> as well.

I double checked with:
"b4 am https://lore.kernel.org/linux-acpi/20220510145640.xx2b3umlrylorxgs@b=
ogus/T/#t"
It does pick up the new tags.

So here is one for the tested-by for the reporter too.

Tested-by: erhard_f@mailbox.org
