Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0C54FD11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiFQSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFQSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:54:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2AE3E5E7;
        Fri, 17 Jun 2022 11:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uv+pSlsao29pPsODnPIQCnHgJtxOCT/XYstpwWFBLKNQTgpmokJpzWngS98TjNJEAjTxG1wLajzeithSHXkSaaqjoNMssOeE1utssSefhCXCM4NVSg7POokIVQ8Ku1GtPdOf8rcIQwX8ADBe0XMr3GI/aaRIoPsywQutAleTiyUDstKunpAmPBqpY3HICK0FRG1DbzRsDYE30Vc93kYWZOzjR380aP7hxW/zr6Vt6iwQdRChaXh44Ki6UGtKPhCmetYTJdld2b/z3MWcTkXABnLSD7cWxBX7RzqCFPdascUnfOcbDWzWzALi4fpgU6hAR9bREsL8h0gJsZ8/MhUcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP1Dz8EmmxedFwMZCfgPY4a9cQzSb9bNt5NCM/6ILW0=;
 b=WqUXgOtyjQ7Gi8IAxcx2tKWFAegZ8090/cfoM3FFceRQO97NayUu5CUnDvd2xS4lG4uUgSq2uyhykS4ODKTKFvmyV+lFsXcahZyn3gru/PAx99HtTNndEVW6fWQehpeIgLF3FqgHK+Uyu2/o+7GTKWDgBZqwFqt+aTzn4ooFljQeiv2Pi/Bm0oatu03x/qxr3vPz5QhqltLvEoqgkLEDBncgd+O+yvwk5Y9d/IZJT9/hJ3j/RJkvnh0Vt0ljic74a5XU6xZoDtlx4JrlWCldsIVDe8hAu8cNRev8IE0NvB+NlaNRMdbBtzjVnRae9ufhccXhnYusS4r0JR+8BiHh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP1Dz8EmmxedFwMZCfgPY4a9cQzSb9bNt5NCM/6ILW0=;
 b=4aj97jNlYWjhNlGyDd1hC17gulWCa3cgBW3fZuwVEP7UVeJyIRqPiIT0ancSouG16Ehe5E1Kkn4X6EFIPchb2bkurV+2J/d9O/gbMcVEQu5LSOj4Vf5DERni1RVus7xoZOg6hqCiaNTsT0FbA6pH1V+JK8mu4esc98Ipe/aWiWE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 18:54:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 18:54:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 2/2] Documentation: Add a blurb about using
 scripts/git-send-email.sh
Thread-Topic: [PATCH 2/2] Documentation: Add a blurb about using
 scripts/git-send-email.sh
Thread-Index: AQHYgniSy95e2eO0rkShvu+kKsd2jq1T8VEAgAAANvA=
Date:   Fri, 17 Jun 2022 18:54:14 +0000
Message-ID: <MN0PR12MB6101040D61CBD6E0E1B588E9E2AF9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220617183215.25917-1-mario.limonciello@amd.com>
 <20220617183215.25917-2-mario.limonciello@amd.com>
 <87ilozp1j7.fsf@meer.lwn.net>
In-Reply-To: <87ilozp1j7.fsf@meer.lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-17T18:51:23Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=46c3b9ec-bf43-4525-9bd7-701764b115e2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-17T18:54:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7a43f235-9d6c-4596-a665-6800abfb3b0d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 257b4ac3-b9a4-4ccb-592a-08da5092c64a
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4241C52855ECDC1CDBD5464DE2AF9@BY5PR12MB4241.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /L48DYXpWBV1/jBB7kCMml0x2nsygwLN2ETair+In0wGKNVWcUe8yVNgo5de+RNr/ycftokJyTabbLh+hGN2B+copZ1pI+86UbV8jGZviX4Bee8fOfodBjSOsQvhhtOAu5xDQWGl/OS1KNt6fxXj9NuDIRgt0C0NOvXipynBdCZ6pXvb6ZyVfHHQq0znHw9ddo41a1eEaRIN0UCY1PlkuDbdk4NeuQNdepod1hfpuZ3tL9WbJ1Ae3S7LzezkVM0kOnS+tqC7UgvM8imREf/QYyJsG9k+VyuYQZZv/cdttabMRxgIV+8fgxd91DD6Cw/yPKOAAFNoHHjJl0e91AmAppDyUlFc+E/MS7P6+ldKhWFvaDbYNymwcoiOLJ8pQpO+mXz2ooUSn/klWcyRezCwmbFwOps1pkjONmNrta2dxTVMxbmZPob+sAfy2xl5zQ9sTlBTF/Q4+UM3eILZK38lppsJIiwWa5ThwLPMd+0LAp7gmjG4Gu8DKAI67ybMW4ffbLgC+66bkAEnYRWtjWLAjUg7PqTcAxsqCXlpOHuA/NyWgsJRjSws1uieiPooxLMAROhwafn9NZTkLFT/IpexSt1ERtICAb6HrzEXd+szP1scTRDpcJVZ8NGonJiQkpFJILzFiyXsuwKCiYKUjt4Ho6u5+JcZ8NnGstCGmO0TTCkLKzX43IkU7k/fB0m95Y2NHxLPwwKAC2V2s9qzzaThhJyJlafG40ExWC7lWKFoER2K7E8CMOXtM+SY1d9lrATEw5RQ64i3Py6oSWlLCmiisAvmuB4Ye193Da1VPbiA8H4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(9686003)(8936002)(498600001)(966005)(38100700002)(5660300002)(7696005)(52536014)(6506007)(53546011)(26005)(83380400001)(86362001)(54906003)(55016003)(110136005)(66476007)(8676002)(4326008)(64756008)(66556008)(33656002)(316002)(66446008)(76116006)(38070700005)(71200400001)(122000001)(186003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnPIJUsylTvGCux56maGq+C185azgkFnm0Tc8GtQDckeRKGRO6peK0rFwJt0?=
 =?us-ascii?Q?K1avNgvNMz2l8NKynoFQ4+1DOpwqvdIWPXTtSQMOVacBrjcEMQqybT23r5Ez?=
 =?us-ascii?Q?pjlQfl/rQp8mADrFCEU9pQomQbDGE6IVMsI/yHbaXM2lakibX3LT/N+kYU//?=
 =?us-ascii?Q?RvzqCvx8SpzAQ9CzgfnTW/0SX1KooGIcvkC/LYCdTurJTKYCTiEJOjaOgVH5?=
 =?us-ascii?Q?OlZ84ZQ13tBOkrCcZngzg0xxB655oXUSrXd43Qd4nWflorApkqmF6BEirjBB?=
 =?us-ascii?Q?SZgBWG884NGHyjyVl7ONHv+p1PMbrf4RhrZ2SeA4Tj9xk+ZqIJkLVbMj9ycY?=
 =?us-ascii?Q?HyZ3wCopcZIP4YtSKCbZnGje4XtYGrRoVIF4RCgwwGRk7dHwP3rD+Lq0aCwG?=
 =?us-ascii?Q?lsqtIkejr4W5vagNcDhE6ZLGWxnLaqCYda1CkbpG9XpY/+p8eBWk5FF2Y7/d?=
 =?us-ascii?Q?HdX+pajNJWA7vv+YIc8WmL0nTylfjPglyoq8P2huIpbp8NAILJoEpuW9Iill?=
 =?us-ascii?Q?gnh9+STK8MvLBVFxvAt6FDB7cullfb1bQo5C5HASy6nwO7JcVEaHuRG34T9Z?=
 =?us-ascii?Q?sWtqEv/X/XHe0OvsvfT/v+HSh9LNR3KBbEB4sNxu4RPF9AW9pGSx2mQM1Jfl?=
 =?us-ascii?Q?vdWjSElHZouYgTrUtUZrER6Yl9qEazRFEABbl2eP9oV8HxJxddFin4JdPiHl?=
 =?us-ascii?Q?FwPljizNYOtvEUdigML/on1kiYCx5/IOv2JBvmBdD9E/T19HwqbgOWWfn20w?=
 =?us-ascii?Q?b2yj2+xnXDCZAFednyEY0AdZGJHkS93N3Z6sSx9NAIodJVPk1vo3oouh+TgW?=
 =?us-ascii?Q?UdDJxPvHq0dl+ize06dBa0PdnjR6fjDx5WcidAmk4cNA5w2NkGi2cJnNoF0r?=
 =?us-ascii?Q?xaRHNe3ym35R4Wc+MmoKkKi+kP02BCUpYYytUXLa+jdf9ud10FX29Di2CthT?=
 =?us-ascii?Q?8cMCMQ4hfTIQ8Lc4RBL2hy1zc+XsAcZD6AMJV2wONcNug4NNIw+Ymn6hL9dN?=
 =?us-ascii?Q?LjjfCaDOpQrKyIj95SvpeyBSliPggOCheLQK+Lg6oPfM2cvrJeFsTLgLkYxe?=
 =?us-ascii?Q?X+mR6e3HohrdBpMkLq2S1lJWw0Bay2zPzhlbBVgIxGfa8g7mxO2bEvEfWHVf?=
 =?us-ascii?Q?ECDO+TEWE1nQCdHBsRFLuJgz3QtFTWbm5MllXkj05B+foGhJvb+OaZZlpM8n?=
 =?us-ascii?Q?a/deq8cdYGg1B7cNiLK59HFMfO+PN2zupNvB32fH7i5K+Dp6xtmatTR9PBwb?=
 =?us-ascii?Q?2Q7PLzDIVxHPvfsTng60Vvsq/ygwAtOri6s7jN5UBkdQ9bGbLXmfq1Ipz8rx?=
 =?us-ascii?Q?m026PsBWTYHf5qywaY9d0EwI30o+WaqB29OzqN3/xp6fo5EVRgH3U6ee3U4v?=
 =?us-ascii?Q?vaddd3le1ZrrbyKKGKbFn3Xtk6VzM3NVYm/n5oQa9lFgev9WpMEfJO/CmMvW?=
 =?us-ascii?Q?NK6tZw6xLI9o0xO8b3qqMTJOEugIZmZpRQaFHrg6CxEJthTOJUYgUfd+Xs7K?=
 =?us-ascii?Q?mEoFaGH5alqPiNxA/T0x66GsMQWzL39iz30ubSG83/vsT9IS6gFR+XC6xERf?=
 =?us-ascii?Q?UNIVYGuCwC18vjtJQm6kbTNjr1SewjS8qxGF1QoJhtJ3nQNOzc+3qgY2F6by?=
 =?us-ascii?Q?KWHcwkO9bm0FJBqjmwknPB+TjYR10zKUcZop8oU6kFWTNgdeYV3KQChigKkQ?=
 =?us-ascii?Q?MyhuHIo09AVCURNHK1nCkGMgWbDlf2PJp6zZKzRscCH+TJfbg05/F/0I0wve?=
 =?us-ascii?Q?J9YFmDH12Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257b4ac3-b9a4-4ccb-592a-08da5092c64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 18:54:14.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vvmt7dL/zMFWt6CiuBOozn2p/xP0PSaLeDvIlGHhNfgimzJN4Y9Kzix03AenXbRY+GB01uMu0Tu0mR7TQshzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Jonathan Corbet <corbet@lwn.net>
> Sent: Friday, June 17, 2022 13:51
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; linux-kernel@vger.kernel.org
> Cc: Joe Perches <joe@perches.com>; linux-doc@vger.kernel.org
> Subject: Re: [PATCH 2/2] Documentation: Add a blurb about using scripts/g=
it-
> send-email.sh
>=20
> Mario Limonciello <mario.limonciello@amd.com> writes:
>=20
> > In the part of the documentation explaining about identifying maintaine=
rs
> > mention the `scripts/git-send-email.sh` helper script.
> >
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> So if you used this script to send this series, I can already see a
> problem; I have a 2/2 patch without having seen the script that you are
> talking about.  Bringing in maintainers partway through a patch series
> like this is not the best way to go.

Hmm; It's very situational.  If you're working in a single subsystem then t=
he
authoritative folks will be the maintainers in that subsystem, but perhaps
folks will also be interested in the other patches even if they're not auth=
oritative.
This becomes particularly relevant when the patches will need to go through
one tree or the other.=20

In this particular case I'd actually think folding the script into the Docu=
mentation
patch makes the most sense.

For now; here's the direct link to this script patch:
https://lore.kernel.org/linux-kernel/20220617183215.25917-1-mario.limonciel=
lo@amd.com/T/#m163ce735a6422a037bb4f12009ebbd9db6985814

>=20
> > diff --git a/Documentation/process/submitting-patches.rst
> b/Documentation/process/submitting-patches.rst
> > index a1cb6280fbcf..039deed14c49 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -225,7 +225,10 @@ Select the recipients for your patch
> >  ------------------------------------
> >
> >  You should always copy the appropriate subsystem maintainer(s) on any
> patch
> > -to code that they maintain; look through the MAINTAINERS file and the
> > +to code that they maintain. A helper script is available in
> > +./scripts/git-send-email.sh that can be used with git-send-email to
> automatically
> > +findd the appropriate recipients for a patch.
>=20
> Please run a spelling checker on your documentation changes.

Oh whoops; sorry.  I'm a bit surprised ./scripts/checkpatch didn't catch th=
at.

>=20
> > +Alternatively you may look through the MAINTAINERS file manually and
> the
> >  source code revision history to see who those maintainers are.  The
> >  script scripts/get_maintainer.pl can be very useful at this step (pass=
 paths
> to
> >  your patches as arguments to scripts/get_maintainer.pl).  If you canno=
t
> find a
> > --
> > 2.25.1
>=20
> Thanks,
>=20
> jon
