Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1814AE0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353436AbiBHSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiBHSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:34:26 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EDC061579;
        Tue,  8 Feb 2022 10:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjiM6NUfYLdZEgcKMOa4cSWP22YvVqHD8ioBqVvsVuZNhZGBXx5dmKfTfGN8PadnN0GA0YZCt0EPVWmfV6uT9KOxbjokbGY7s7Fer2LlRNikLGnx4vdfZ+ldyQR3MfRldayT9GcmYNUPGeQ4N2CwCrm9MiieugpX5jXAwPsxj3f2A80SXhWhhPkRjv19hdoBdN9POlHDDplK8l2RHxLvivPPoJhsOG75Y9lw9eXXNov+nx1q6VC8HgXofvzeuXRnQtiPJDoUjI6IuqZQeqI1xDMSDetdl94JEwJKI4I5cy38LF45yl47WNDRzsOYcA7himR7T1tHkvP3alpBIxzPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir20g7HJxBGHL6MJOTnKDqQ60Ucy63MEC8bBiNJWBgo=;
 b=XTgQLKtyR8bI6U55hZm69vGjbB8bdVk0YFsHHjyB/dux9Qq6/gQyqVZbjymxBtQof0ZpHZie3qsHwADpj2kK6Frm8y5VO1mumLe9mErXHxbCDS+Zph5JkMgS+3eeEQKRpqhSFhLK+mqsl32ePH9xcD31BW8nNVNoLWg6kKfLJ8gBvDipT/aVkl6nI2RXsKhQhWFVSWThZwoc28x07xy0OOlPism91aAXPjbkonY3CgM6j1INuNGhJoe4RQTy9/o3IGHnwlwuZypyjKuZMO29ZhUE7tQfsaUUYhXp+3dpMa6xurtwQH8RD5oMHWpQn82FbjnsJLpefBOAgUF69kCR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir20g7HJxBGHL6MJOTnKDqQ60Ucy63MEC8bBiNJWBgo=;
 b=eSfc/I2B2/Qi9/cYAwwi5mY+5uw9iNJfGR8zP2Vmek38FtHPvxoVHgNjquFNK62cXNRWlvPReQlprEeq6PFG3Di0ZnxJuclwmf+5ysCqUxOn87iXUp2OwzesayCUzk9tzDjP2+LIzJuLO+krbRRJX+hVUimsUPV9pL9j4AYgqa4=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by DM5PR21MB1815.namprd21.prod.outlook.com (2603:10b6:4:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.4; Tue, 8 Feb
 2022 18:34:20 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e9fa:3037:e252:66e7]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e9fa:3037:e252:66e7%5]) with mapi id 15.20.4995.004; Tue, 8 Feb 2022
 18:34:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Oliver Sang' <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        'Yin Fengwei' <fengwei.yin@intel.com>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
CC:     "'Alex Xu (Hello71)'" <alex_y_xu@yahoo.ca>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        "'hch@lst.de'" <hch@lst.de>, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Li, Philip'" <philip.li@intel.com>,
        Rakesh Ginjupalli <Rakesh.Ginjupalli@microsoft.com>
Subject: RE: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Thread-Topic: RE: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Thread-Index: AQHX9OjnI2iGAQwSWUqnCtF9yw5sM6w58EYAgADmHHCADSP+ooAmyATggBuHkFA=
Date:   Tue, 8 Feb 2022 18:34:19 +0000
Message-ID: <BYAPR21MB1270046D4FD0521E5C395376BF2D9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
 <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
 <27973649-193d-a485-1ca7-983a53c7cf78@intel.com>
 <20211228134926.GA31268@xsang-OptiPlex-9020>
 <BYAPR21MB1270F7AC484CBDFD94B10726BF5C9@BYAPR21MB1270.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1270F7AC484CBDFD94B10726BF5C9@BYAPR21MB1270.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f700892c-76ff-4635-b077-305f0a059b71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-22T06:05:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9911a153-c921-4bc0-03cb-08d9eb319ef8
x-ms-traffictypediagnostic: DM5PR21MB1815:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB1815FA2C6AF88AF4A7946BECBF2D9@DM5PR21MB1815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41OJHL/4peaWuGAJjWnDpeHil1QhaSNEVK+BeferobJrUyaJi1iN6fZCx2C/A0hXbMYMitwCArC4nKiLSdxp7Bx2MhGW2LhvvsFlI9nNAVFTJhE3Cf26462sxsF21bFDkiNKJImou8R0710Zw14H8pRe2VBF74QHsv4vG5oSGreia5rn6ej7QSczsqwgIYCp4cmxJ26VYZMe9DW0ydAkTo7pMjSYlCeDVoIluW0zRUli27Ts4gbQC2get7vaHYOUwhQ7VDhN+EJOFn9u8xKOS/4HE5PXDzNj8ZncPq/E/t6TWEXfH9CXxBYFjJRv0d6p+Jsfaq1U8xROvbqIYrP0mil9QorT2depimZjC19ujSzilAXH3pv3w/eUxIEbqFphcwHQhf7lRQkqRNEqTnpFtNELw4wzEYMCJNNOfoogyzegs+67Rk6omytAlauUQmFl66Rd2dd6+Zc/eAbmmq05+9UImzS5MAGVb60Aapt3ROcO+jJUKS7QlpvMpX3te4LnZTDwgiwMXppXYkXDh7O/ZDNsqqSJCRTjPn0qQAqEM0T82ZW6jonke6ArAyfOI1ZRtvxKiFJDaC6tkgu1NIOPMNvcKyOXLvM16qNYO3B753Q/nXUUDETfdAKlffyNCtGjUIKgAC1kS2YoG8wtOtTYEbswMkNqIbJG+dDdrVuqZZBOAOcDcHmgwCJW8QxOfJMsgVMGu5iWUA60zRJSvNcf83KnB1r1E9cJMs/JAuakGnQkXEVwv7RdJOdFBPMR/v6hos/PrZXndWitJh35BsyTatB28GW9LhRHHEidfBdw939q7nsU4cIxjyRQaRn6UvIphSuJNq/ouDMxQwFrIFwJlrnBfy671SRwPEKzPr3IqIA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(10290500003)(186003)(122000001)(316002)(53546011)(38070700005)(38100700002)(7696005)(8676002)(508600001)(66446008)(8990500004)(6506007)(26005)(82950400001)(966005)(82960400001)(83380400001)(9686003)(71200400001)(2906002)(55016003)(54906003)(5660300002)(66556008)(86362001)(52536014)(66476007)(66946007)(110136005)(76116006)(4326008)(8936002)(107886003)(64756008)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqHWnQ0bEF1Z2hRxg+0T6/+S/W64Yf/5loZWtUF8+EKuslVy3vNTpz+Ga3t8?=
 =?us-ascii?Q?nrsPqGb+3qZ8S7FqBNOav5A3Tq5KQCH9pfX9A5tDF4iFrk8RtKNDagLM0W2i?=
 =?us-ascii?Q?T50EeTXq/1rkzVEnuUBdQzyIy2nrB9Gpmb4EE7wwWWga3s4bUNOI3/gEFALd?=
 =?us-ascii?Q?D0JufKlCckZ19e0fLJjgIFPyVYT1IrL+89SK0+bq2cIBPVURxE00d6uEl6kt?=
 =?us-ascii?Q?8VbSDDttJrBq48KqwSEyKcBlkurpisKDMsSHD3wbg2vhF6PH6n/RJIuSGyuY?=
 =?us-ascii?Q?HAB1oXmBE3LVCuqJP8yrwr9hOheN1AkM36QNM74OqF47SLLXqp2aSzAWScvj?=
 =?us-ascii?Q?v6IoeML4uaDpG/ulfCDkDwbvOJyqABFoSXCX/m6kNDB868zv30RGsrpgxLIX?=
 =?us-ascii?Q?zKRUfPxNBf6jp2qS0FXogNnid6CORQjo4Noucoqh693hbhAkjw9guUd3+dtO?=
 =?us-ascii?Q?kwXsrGebMCgPrTJn/IGnaiZvLIGaUJ484Z7Z8QAGrLxkddrIBoUdcbtt+N7V?=
 =?us-ascii?Q?G17lxVEnNr4xcB9hgLfp65591pnPy8V1mPv2DWY3fIiVIR2MVdCshTlJS+dJ?=
 =?us-ascii?Q?F9cz7UZM+3ciO55UGoCxxDWvWkf64xEbV993xDeYHzbx5v8hCKC9F4leUdQf?=
 =?us-ascii?Q?PczEC0kBsX0hvDRcCc+h/6gvvrrIO1Sg/J1I27wppkWYG1UUu/0uPqv+hlhl?=
 =?us-ascii?Q?G05M/UA2dXPwv9HH6ZRz7j6wFbIepL301eRMEBYr5DRrIQtrAFgONvnsKt0G?=
 =?us-ascii?Q?C0XxFBNWv6mB79JVBOe2NWljUJ2JG0S64rA57SMlQL3SjyQHq0eZXkwFvJ2o?=
 =?us-ascii?Q?zKfjMgyeOdLcYHVN1G+WHo/mvY6h1h33RG9ZPX4BKc9bKZLPpazisRvxH6XO?=
 =?us-ascii?Q?RL/hqB1QazZ8O0wxIJpLLAP/WMLFqz5FQQ4cZWmJrbI8u1dHz2AzebPzBrKN?=
 =?us-ascii?Q?UlwNGjToannjEi/KRyXDxxwg/LZh5VFvNElpQo4edODlUCX95XEfKT3RwSvp?=
 =?us-ascii?Q?P+VoAoDlwmzifglpH4WGhNn2q47lEBwb/oUgLEz/SmR3wRtOsheVYxsIrFCC?=
 =?us-ascii?Q?YNsAdU+FjNYjf1WVe+f6Jn2YnuX9vSXWIb4LUOqsZpmdKVQsuiPIrFNMKE7o?=
 =?us-ascii?Q?7VhHlEx2m6FCJKNBzlTFuvto9zCAiuHH6FYDBi3nykB8gzB1Pm+58R3HqB3K?=
 =?us-ascii?Q?mWWqRoqsNzgKhlUF/8dI5/scFk/zEgnjCSx3dbVxoOHZDYhBR9Ua/TUhuhZk?=
 =?us-ascii?Q?xeOMGtuWIZ9kan66M4hw3tOOWBB4a87yq83yb+6YkhIWz6MZDtSZtJo9fbf6?=
 =?us-ascii?Q?fdE6PR573vtZEMYCcgjJPm6wvvxAZTsQ3w3K3pHLHYZ5W1O2QKdx/bTSqVNw?=
 =?us-ascii?Q?/Fybaem4u+CvrGeeP81BGUp6u5W8tRdUIbOGTpEzr6AOGmwsPHlj3PdAmMkS?=
 =?us-ascii?Q?QcTw5HPtcw7OLbdhC5Jd6sgwvh49koHAVwZyH8kUCtPg/GzYOsm5Qi8sNFgL?=
 =?us-ascii?Q?bDJbgxRhARpI4KP3r/crbNnH1fdmW/ajkUyWmJzfWgpNC03exRldILS0DB1a?=
 =?us-ascii?Q?1i98I++8MhImQSJIDFmTjfMVUJQAWsyjCu0TJr0zLRHmQTzUXyLHZuqAqG2/?=
 =?us-ascii?Q?KqP/AcBsZpCL1KVjUQuN09E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9911a153-c921-4bc0-03cb-08d9eb319ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 18:34:20.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntqIgwhOgE2QcQghPpN3W1Ko6k4o91j+7wr9sA2b0SgjkJ9Ys0a+D6YGdPqqj119WDJM6kUHDUAowSzl+evhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dexuan Cui
> Sent: Friday, January 21, 2022 10:15 PM
> To: Oliver Sang <oliver.sang@intel.com>; Jens Axboe <axboe@kernel.dk>; Yi=
n
> Fengwei <fengwei.yin@intel.com>; linux-block@vger.kernel.org
> Cc: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>; ming.lei@redhat.com;
> hch@lst.de; Long Li <longli@microsoft.com>; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; Li, Philip
> <philip.li@intel.com>; Rakesh Ginjupalli <Rakesh.Ginjupalli@microsoft.com=
>
> Subject: RE: RE: very low IOPS due to "block: reduce
> kblockd_mod_delayed_work_on() CPU consumption"
>=20
> > From: Oliver Sang <oliver.sang@intel.com>
> > Sent: Tuesday, December 28, 2021 5:49 AM
> >  ...
> > Hi Jens, Dexuan,
> >
> > On Tue, Dec 28, 2021 at 10:30:43AM +0800, Yin Fengwei wrote:
> > > Hi Jens, Dexuan,
> > >
> > > On 12/20/2021 1:15 PM, Dexuan Cui wrote:
> > > >> From: Jens Axboe <axboe@kernel.dk>
> > > >> Sent: Sunday, December 19, 2021 7:28 AM
> > > >>> ...
> > > >>> Dexuan, can you test this for your test case too? I'm going to qu=
eue
> > > >>> up a revert for -rc6 just in case.
> > > >>
> > > >> This one should be better...
> > > >> ...
> > > >> Jens Axboe
> > > >
> > > > Hi Jens, sorry -- unluckily I lost the test environment.. :-(
> > > > I pinged the user to set up the test environment again, but he's
> > > > on vacation till the beginning of January.
> > >
> > > We hit this issue in our testing env also and will help to verify
> > > your fixing patch. Thanks.
> >
> > as we reported in [1], we found cb2ac2912a cause big regressions in fxm=
ark
> > tests.
> > "[block]  cb2ac2912a:
> > fxmark.ssd_f2fs_dbench_client_4_bufferedio.works/sec -66.0% regression"
> >
> > By applying the patch supplied by Jens Axboe in previous thread directl=
y
> > upon cb2ac2912a, we confirmed the regression could be fixed:
> > ...
> > > Regards
> > > Yin, Fengwei
>=20
> Hi Jens, Fengwei,
> I finally regained my test evnironment and tested Jens's Dec-19 patch
> (see https://www.spinics.net/lists/linux-block/msg78065.html) and it
> also worked fine for me, i.e. no excessive CPU utilization even with the
> default dm_mod.dm_mq_queue_depth=3D2048.
>=20
> BTW, Jen's patch is not in the mainline yet. I tested it using the linux-=
block tree.
>=20
> Thanks,
> -- Dexuan

Hi Jens, any plan to commit your 12/19/2021 patch?=20
It works great according to Fengwei's and my test.
