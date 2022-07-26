Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A0581820
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiGZRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiGZRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:10:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E111154
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqrfRYnUDmWyO/1YTulSDrpXDrqkUdA+AskZRsizCV+hm8aaeHI20vppXJu/EDGt5ni+VgmLvAUTIoLtm4Ii38cBi5A80q0jmzCao+T2TomkTXsf4H6cfSm08FPWazQGcBGm9J8Bdd5+nFODfb958c/BcpBsC2JRlcUQPU4xkfRzsey/n6384n0w/nHvQtxrez+YKjTG8Mo4t4yAUUMfrrE7v0J4OsuMvf699vYO2oCuFDsknM876ckWVvOkIvEk6N0EWqGyX8V2E64HqZ4xW88OFesNgnULrMzXOJGh13DBzzTfqjAlon3IxC51/RS00auvVjPmJNm4BRRO4Y2gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9jUQCQHqT93/haWEgQ9gD+bOUfoSru4rDjG2VVnD6A=;
 b=akOOCRw0t8JtLiNkokkoVVreK9ciRjdLLeLS9buqfPsoSpHJ5KNtlyUhLTfMmDH15WRSRq+RVbTAhHWik54s5IdJQPv43mDEa4TTCMiCLrZb+r+f1t6gadQCnT7MzCIwbotnDjsWn68SRkdgg1tyxOGFKqLF6v5HjmmROE4yShUAdQMF5c3/OoPS6YJFOjsHfrSdb4YrnkjgP2rQe/LSmXGc9hCgxm+eyPrHUnmiPtF3szO3t8vTc3Naq2wx1VSwGBSwaajHGYPIskYAT8b/gcCdxJD7qVEWkookm/gvwxh96yXXv20nk1XT4F4DTL6YWmrXqJ0bLtK+aixr/NxUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9jUQCQHqT93/haWEgQ9gD+bOUfoSru4rDjG2VVnD6A=;
 b=BaLC6XJtMoze3fpbjZIamHsUbVE61MFxyc4p59thata1SEt0nSp9A8tMqv7y5QBpBVcArViueWJ27H+r5pEhRQW/4Wcv7kgMNv81Qd5uf40vWRlbTDTsE0MboJFxDk7Ccg/J6RM8jslugNvjF8BFn5R8ltWbxowwO2eptKkEgSw=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by CY4PR0501MB3779.namprd05.prod.outlook.com (2603:10b6:910:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 26 Jul
 2022 17:10:47 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Tue, 26 Jul 2022
 17:10:47 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Joe Perches <joe@perches.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "rajeshjalisatgi@gmail.com" <rajeshjalisatgi@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Thread-Topic: [PATCH] VMCI: Update maintainers for VMCI
Thread-Index: AQHYoEQyk/xBLr4HNE2eyPGwuSIgoq2PYdCAgAAGloCAAVrWgIAADHIAgAAGZ4CAAA6ugA==
Date:   Tue, 26 Jul 2022 17:10:47 +0000
Message-ID: <A1018348-F10B-4CD6-A99B-C45C0C6A4758@vmware.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
 <YuAD90UfLnf1Ojso@kroah.com>
 <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
 <1c536f8e9666725ce9f3eb97acc34d08f38d2095.camel@perches.com>
In-Reply-To: <1c536f8e9666725ce9f3eb97acc34d08f38d2095.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f108e08-1d97-4014-0341-08da6f29c88d
x-ms-traffictypediagnostic: CY4PR0501MB3779:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0C0LjZgg6RRdYXFf5aDgTYJAcp8KDl+NSCwb8wr65LvnLK1Asv/Y5jsw4i+ZkVqdYUssvbS5/1ddTxUDy7ExxLS5tkRweOOeGPcPKl/3xygJns6tfw1Z7HpyMohPNu0ozNAu/Q/er1jqTsNnK/yU1dERElcK0+KQWuYe+uV9kjmMmohmL/7T06Q0wBBmX9UuAGLWIF9E8pGE1fmmUP3bXA1oi4WD4MuErhMb+S6pC4aSp9/tSahiU7vLYXYDEvAgkQxMeo6zpNikbUhqyyRqnBV4m/Ly9ezxbw2XyG8zY9HUldcj2kFimiX8/wiHL50YrJ7xo7bVayXv+KA3R7xjP2B7klSu7j+iICSPQSOZ7hFKjD9vuD5ONbeL9NjS5cf7jhm2a6+Phofnz97rDNIjDP+0KlV2uZcoZuMDrYgeNd6/ftAe3P6tsNqGbhNNYPQbE998KI7vYNppdLOCHsqBR7H4T2jWnTYptFC8sLw68A0l/MeiNF129fT9Wd1BK+U6Y9n0yEnZOr4wERZ9SypQFEMrh6hyPr5SflWSL/JtaDIBmrXI/bzsrTfwi8TPwLFk6BhzJh597bFZio9y+M8ZCpM5Z0wJxS8nc/aJGT+nHwNfJOsdNLOix0QsyXbTY6Ryw0CHHUq0u9RjRf0wq19U4BqIcEy767dXMnkSpLZ1HjoJQhXElrY4bWiRKn1WHWztf/SIaOa7cUZutpofLoYYyMGTIVho6+Qo1FTJMDHqx9kZX3fvOIzwbf0UDlp4HXq20BbrvHCSMhjGiFex1V1ePCbEEU2eRf6ELl0dI64nU1bKwu42X3d5ujzSO+qjTgOnNYexL3g8m9bGHWzqpKLmHAD5ndyS0Wi55Wu4CZi+6KPG7cV/yHEbCAv1dSfOG6bh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(33656002)(36756003)(38070700005)(2906002)(71200400001)(6512007)(107886003)(122000001)(86362001)(186003)(478600001)(316002)(6506007)(53546011)(41300700001)(54906003)(6916009)(66556008)(6486002)(76116006)(38100700002)(64756008)(8936002)(66946007)(5660300002)(66476007)(8676002)(2616005)(66446008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E8zprUj/cvuL88TUbCgxcULav3dt19FeiNz40I3odqdU+WjL8qezEDqEjPox?=
 =?us-ascii?Q?4EJm/h9+C1FHwQf0fx0to9qQWiZ/lbkYPv/vFDfVAnyvKC0cXvJ4CI8Y4YSc?=
 =?us-ascii?Q?0PyYNRVCY5fLkN3QZ1ZBlfxUydwJ7NbmkqV5yPZEsVXZoNzsQDDSsvwzZct4?=
 =?us-ascii?Q?GbNgZG/9X8wXgzTUaMAlT3GJlZq9v8RJ0GhhEJoH6lHm6PqHdLhDcBJGpHYP?=
 =?us-ascii?Q?erw3vTNo73KEIswNWwhNJcYIGLq4bCLMo4dN54+BMwrwd3CnW092W4bds0Dd?=
 =?us-ascii?Q?O4HUtjzi9rR06S1qKrRdVxCYSA4zy2yKOjcTgxi49WUBGjjHzZnasrWjYJTH?=
 =?us-ascii?Q?SRH8xcSx8Rg+YG5QVDyKwCIZcArVaWHbJxlMeiVX0pOp+cCNmoFiCFoP+zKy?=
 =?us-ascii?Q?lq0ph9NcUoZDh1kYgJze0dn40tJh+MiuBFPSosEBf78UDXRmrW3+lLjVR+4z?=
 =?us-ascii?Q?A5y9U5YA+1vPxWryOfFcjgi5bAFEdFBS+wPqNYhOFLAUh936v/EJM529tQn3?=
 =?us-ascii?Q?XZVMy2f+7h2v8fDkVbYmooIh2kbL/sd8cVjWvoF7ljoHIp1googAKf3cEIFE?=
 =?us-ascii?Q?ysLOe5zi3Fdb7EUOyMfwZzK+ydigq7NxbEJ/UCUC6lmYIwqAzb9Z8aaCcH8w?=
 =?us-ascii?Q?17RVljDLAP1mIXS/yBAvpgyh7jcNbzoLqHRhLYhyDKgskBt1qiyK/JTZ0GiL?=
 =?us-ascii?Q?3vMPBOEWRhhb7qpSDt4uIFlrFD0LkOZdE5h90TKgDcJcwVZZ/FwD//UjRXm+?=
 =?us-ascii?Q?W4uwZEMFQXk6XLAyuebUeMAKDjHcwoDy/X6gnhfJ95vBIZCJ2EikUYJ1RPdC?=
 =?us-ascii?Q?Hnro+9sQ1ThEKRK5zyBiyRuVv3MdLnpdYbaC0Smtg+WJTDdrh7ThNrToa/Yh?=
 =?us-ascii?Q?a9gleci+TEUdgPvbsbJ2Db3btqVihhegZ5xZnQO0xM15LM128VojoQG5taqg?=
 =?us-ascii?Q?0cZjeOfbGtnJQfinZb8Z4xzutgDuyBmMpPEiN7GNz5Dq2ScEfyuCm4+DIHPm?=
 =?us-ascii?Q?tN2HHTM/uqATC/w6wAXeEhRdzoqUjsxwdybZrkb6zamKTyyuo3vryGfi6vfA?=
 =?us-ascii?Q?x4mw7rvwMDmHQngzTqvtjqEJYnyOw80WDSNNlxWmAxw5A39d6D+Y6n+tbYPw?=
 =?us-ascii?Q?j97hJr/XweUP2/H2tsj7mwqqgUC/YXJx/U9WJctakDxDfkC49IMCIQZ+dq26?=
 =?us-ascii?Q?7F9BY9PTcd62CrpqGTRkd35cP9b6vrBTOS95sx4l36KhPeBL7TLJ1uJVerXT?=
 =?us-ascii?Q?BAM0pC/v87UyNJw2jSefpNo4leTVBeBLlnSZI7wu61xeggjgJwCjrD2JBlsD?=
 =?us-ascii?Q?PmK2WRs8ACh5a0Rg15Hou0G2IeCZrdt4gj0kTJTxmfupBhaHS3becmS3WLjd?=
 =?us-ascii?Q?OJXCnSrf5IS+xeOCnGHEXzvnfGruzOPpIUZZZtIp/1zG1qjKi/qm27u/4h2J?=
 =?us-ascii?Q?A9iW1bbcTTMHNRFImvhSOvi4CIF15mV5R68DSsVS4t5XqITc+eP/YCnFVoYf?=
 =?us-ascii?Q?oABGwRKYgRGX+ZSgp7uiRgiagRwU8pNbAknvEbnXCVoKfSXTrtwRCjlPV9Sx?=
 =?us-ascii?Q?g4BtQGgN3bTdBmgIZHhNv9Y7sC0dfCH7/QgNFcGnuAE7udRNU8bSqUp4lKpF?=
 =?us-ascii?Q?ZRm+af3VEcYv09awy2Dolk2te6QjexHRTtWiYyh3/ta2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0132BE5D991B3C4CBAAF57C34304FC37@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f108e08-1d97-4014-0341-08da6f29c88d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 17:10:47.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbXYZR0+ZFW2D7w5vVfyRSSZod4Larlr8M7Gqrtl6JLMHZU1rl+tJ5qOA3JwOPRrEfXCImY7dQY6FMaPgfG/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0501MB3779
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 26, 2022, at 9:18 AM, Joe Perches <joe@perches.com> wrote:
>=20
> On Tue, 2022-07-26 at 15:55 +0000, Vishnu Dasa wrote:
>>> On Jul 26, 2022, at 8:10 AM, Greg KH <gregkh@linuxfoundation.org wrote:
>>> On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
>>>>> On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>>>>> On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
>>>>>> From: Vishnu Dasa <vdasa@vmware.com>
>>>>>> Remove Rajesh as a maintainer for the VMCI driver.
>>>>> Why?
>>>> Rajesh is no longer with VMware and won't be working on VMCI.
>>>=20
>>> But employment does not matter for maintainership and has nothing to do
>>> with it. Maintainership follows the person, not the company, you all
>>> know this.
>>>=20
>>> So for obvious reasons, I can't take this type of change without
>>> Rajesh acking it.
>>=20
>> I understand. After getting in touch with Rajesh, cc'ing him via his
>> personal email ID.
>>=20
>> Rajesh, could you please provide your ack if you agree with this patch t=
o
>> remove you as the maintainer for VMCI?
>=20
> If being an employee of a company is a criteria for maintainership
> of this subsystem, likely the subsystem entry should be:
>=20
> "S: Supported" not "S: Maintained"
>=20
> MAINTAINERS:VMWARE VMCI DRIVER
> MAINTAINERS-M: Bryan Tan <bryantan@vmware.com>
> MAINTAINERS-M: Rajesh Jalisatgi <rjalisatgi@vmware.com>
> MAINTAINERS-M: Vishnu Dasa <vdasa@vmware.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: linux-kernel@vger.kernel.org
> MAINTAINERS-S: Maintained
>=20
> Likely that's true for every VMware entry.
>=20
> MAINTAINERS:VMWARE BALLOON DRIVER
> MAINTAINERS-M: Nadav Amit <namit@vmware.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: linux-kernel@vger.kernel.org
> MAINTAINERS-S: Maintained
> MAINTAINERS-F: drivers/misc/vmw_balloon.c
> MAINTAINERS-
> MAINTAINERS:VMWARE PVRDMA DRIVER
> MAINTAINERS-M: Bryan Tan <bryantan@vmware.com>
> MAINTAINERS-M: Vishnu Dasa <vdasa@vmware.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: linux-rdma@vger.kernel.org
> MAINTAINERS-S: Maintained
> MAINTAINERS-F: drivers/infiniband/hw/vmw_pvrdma/
> MAINTAINERS-
> MAINTAINERS-VMware PVSCSI driver
> MAINTAINERS-M: Vishal Bhakta <vbhakta@vmware.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: linux-scsi@vger.kernel.org
> MAINTAINERS-S: Maintained
> MAINTAINERS-F: drivers/scsi/vmw_pvscsi.c
> MAINTAINERS-F: drivers/scsi/vmw_pvscsi.h
> MAINTAINERS-
> MAINTAINERS:VMWARE VMMOUSE SUBDRIVER
> MAINTAINERS-M: Zack Rusin <zackr@vmware.com>
> MAINTAINERS-R: VMware Graphics Reviewers <linux-graphics-maintainer@vmwar=
e.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: linux-input@vger.kernel.org
> MAINTAINERS-S: Maintained
> MAINTAINERS-F: drivers/input/mouse/vmmouse.c
> MAINTAINERS-F: drivers/input/mouse/vmmouse.h
> MAINTAINERS-
> MAINTAINERS:VMWARE VMXNET3 ETHERNET DRIVER
> MAINTAINERS-M: Ronak Doshi <doshir@vmware.com>
> MAINTAINERS-R: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> MAINTAINERS-L: netdev@vger.kernel.org
> MAINTAINERS-S: Maintained
> MAINTAINERS-F: drivers/net/vmxnet3/
> MAINTAINERS-

Thanks for pointing that out.  Will discuss this with others and send a sep=
arate
patch out.

Thanks,
Vishnu=
