Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31EC59FE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiHXPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiHXPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:34:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80FCE1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRbMWNCYlvUdZIuC1eEkaQKnGKJbdHYwtVgF9tI02pHjOK44sJy0C3f6AYepJOpm/PlfCDPgwji+a1i38cTbiIZ3wRsKaZVk7ElaROQGDB5pzFFYT7yYUAsByOIEL0qHvDOfhKKPhjmW3IV5/YltXyPIGiW0+lA5rfc3FbxOTr9v8ntIo1+L2PFX8yS9Yr2bfiMM5PSUR+LAiQ37o5Us07JL5Cgobg68kb7e8V8tpmUv07eIXqmMqAbFdd28DhiJ1Q64qC0P8WoaI38OEHisjvT5+wLB7zvPDx8Tn2KBBbVBJEdTeq4zfil/gYAV8glI23PtabAVH3ioYyNczLsO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vThxovZ5/igdGQLjTeJ6a6WsL3T19QYfk5tgkz+FfeM=;
 b=HhNeHI7ARBu3tTyX+lHOozqAimu33gLGRyhiSuYLyEmBnVi4CFWhcmd5by/84YH2LXrbOKY968+uYF8Bce5wyAoZuHjNpLrwz3k0fAOZnQQIu4AaRsVX8arPcqlkFjeq/VCSAJ+FCfisOed0lzdimogApnhhUTDl3ne8Vm9iVQz/XquE8HawsRNKdSqsLAHHxPzPWEFVwj0+35LXrO5ckRHT+riSLkwnFKODIjVoAL7jyCsMI//c1iOrmZS1FTOZVRn8Q+E+EZ3Xf7ChM1Z7OLE1fAShKS6c+YBL8GrX6X+Mg8/k7GpmFFXm05I6G7004t2jFXI3vS6iit0CyZ2acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vThxovZ5/igdGQLjTeJ6a6WsL3T19QYfk5tgkz+FfeM=;
 b=eaqBaf0XqYz7fNZ8zvuOH7ejpDWzweXHBAT7TYYuVtLxptCr7hUeT+Femzx+sK8anpxxzcN8ODiO7iU7zoTJndl3/Un++LnbsSO9HQTl9nN5JPnxmtccnBPwc8wsq14OPvwD76G/jFJMKy8I3iaslGZkh+1X33dtTLIWHaGMZ+cAhpLWkgAR4jzAkJgMB47yt6fH1Em5rhLdnskIAJCWDmxN2V5sJ34zz8O0fbX1+ZqAXewtRXc0FXzcwYl5Llr90orF0NCc+P2vTVzYcaO8PYacINbAfRPSIOwC8YiXo+/VIrVyjpYmyqsBal+oK179Ya5YeW1Sne1YgEu3eZoJCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.19; Wed, 24 Aug 2022 15:34:50 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::bd0e:9ec:167b:a19d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::bd0e:9ec:167b:a19d%5]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 15:34:50 +0000
Date:   Wed, 24 Aug 2022 17:34:44 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/gpu/host1x/context.c:65:23: error: too many arguments to
 function 'of_dma_configure_id'
Message-ID: <YwZFFFCD/LPDZn29@orome>
References: <202208240444.uTBVAbiI-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otMSDLJUvslt9pFF"
Content-Disposition: inline
In-Reply-To: <202208240444.uTBVAbiI-lkp@intel.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: AS9PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::9) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a4b830-cbce-40b0-c0b1-08da85e62ebb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUEuyOfdN1Q7cnX6V5e5uFHN+6RuVJXi6bmUOxwkFstfOr97/aw5VkcV4ARRybMfi0PrfsK3U1Ujp5wRVd4rs/fJtDyjyY//lJ+UstHNZlrsig2KnUqHS1xdXZtr/XVPK6TbSg6wTPXn8zmJEP/Mw4j63hIQsbO2KkpmTo0rVQI2gWtWA96qpwqtOJxfvB7NcIyY3YazqwK8pBEkDesTQFFNIULifxSRYFYTP1rFoh6vkAaq2xEecJbB3CmgSyCevuHgGuQq6g8MKFAWkd1wexE1mxCVmN211vAiWzYct+Cho22q7sW3Hpmc6ykVkmJTyhX6T6eiutRBcUdLeYlCgARYO4XIb6yK9rXWCDw8s79W0rQ/HwHRQ4f+1uteNGZ+yWCMfXdcbYukX++n941/ma62lMFYyCtn80fsXi7HQ3QafSPCBd6+ekRwJi0XTm+dRyiaZOXeVHIRevtzxhWcafC7DeXz2/lVHeiLZmHnbPCxw2mk7924Ei2Pa9mxAgEDS20iRWt5kn9K5usvhG2UYgcIP5VYhg6vAaNJGA0AHGuRXGmYwrwTvUHjnDH+GMpVebue10bANTkzPmk3SN48IYKDZCN4eozVdO6dFvp2Ej4dQoIHOCp3ieKQuMDdfsHhS+5qJA2aeN91UnqDouhS5ctj4Qu2cNYJSuLACV2qRwTOClhlcScPsj+cnrg10pRG0cRiau1/iD+0/ELcHlqAPO1yAe8bxKJXgI6LNjyjRynP/yt8saqSqawDpf73CuBsP3QExGqNoGB2h6QeZkkKgtdVJl7YyOEhuFJsKFhwlKqV3tQVRPUMdKLGNXpXuwbiwOKTPPzooP2UPiLT1k89OdUwWG0fmkKsNgM/+A3ZB1M9CofCfE2dJI+XxbLxg1/Hyxw05KAmtZMV2u8qyq1VRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(136003)(366004)(66946007)(86362001)(8676002)(66476007)(4326008)(66556008)(38100700002)(316002)(83380400001)(186003)(6666004)(21480400003)(478600001)(966005)(6506007)(9686003)(6486002)(6512007)(41300700001)(33716001)(2906002)(44144004)(5660300002)(6916009)(8936002)(2700100001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnUKmHAdn3kL6H8ci0FjNNxUicJsMBzj73r2bPmga1GNYwkKExRM06zyDGcq?=
 =?us-ascii?Q?0aW0/RYBoJnHR8/h61g2vUc2MOHc/g/3aglWDZ0EDubJhhDDkr6ZbFtQLMW4?=
 =?us-ascii?Q?f3Gl7l4WYqzCO+m6iMShaXmDDaBV3zW6LGbJLa9myPmybtJDzV8Q/bdN4td2?=
 =?us-ascii?Q?BijafPBntNx4Qe5GJvUbdgRBfVk0+FZO4f42bQ49bnF37BWDofig0xi/DF+E?=
 =?us-ascii?Q?5H65WLwWvqPTNWnQECBnbPTJ352aUtP49xX7dWm3YTxzs7t0ygRwp/i2DMpC?=
 =?us-ascii?Q?nnDVWqW3XWUAUaJUyrzy1r2LrEZK49Cu924U7fJAm0t6fqdfGDZ+KI+XMF6i?=
 =?us-ascii?Q?mRgoY7uaFiq2weHI5zrULQ7ONUxP8NyTpBR+vOdt53LXYezPusD6KdicdiTT?=
 =?us-ascii?Q?y/Z/84IhCaC6y9fg1L02FZhDUJ02UXN61BhUPseF2KGq+j0OT54+xG+NHVW8?=
 =?us-ascii?Q?ljBETIrlooDFr7P8QWrGhWVZdoAsXeiBNqRvsxrg0JiE9y44UGBHfNkwQ4bt?=
 =?us-ascii?Q?C7ChcbVzvh97l0zdj79tDZYMywXc3IVIhUOBdhUHDT+m8jrVuBrvtk/O6/j9?=
 =?us-ascii?Q?ng6vURDfpidO0KoPZv6kYOAiHqVcOqr0dxoI9mx/dB2qpR5Q2hANtM4UvWeM?=
 =?us-ascii?Q?X8XCSp5MR9Aep0XUmoX3ygGKj0H4nBByyaFXxAx3qNd4JsR7JnnbHvNTnRuB?=
 =?us-ascii?Q?d17TZz9AgtmtKamAKhOnXCnEd07DxFUYbBy0HK0TlgJSdj4InsaxciMmY0xY?=
 =?us-ascii?Q?0Wb5ckpjXaSXIuhMCaNtLBR9++N6I7fad4B+/cC80497rlnyq30SgzZgt7EL?=
 =?us-ascii?Q?PIicR+yfh+9VMpNLSIlHbzEUMsUvUDeOaLpWjB3aB7x57sB8VBYxQm6LJvjd?=
 =?us-ascii?Q?LcR/I0Cbmc+sKvvOQQ8OLwgXSFKRgZ8s70h9/ZnUtrXIHzLyHsd+MAT49++w?=
 =?us-ascii?Q?kT8XkL9DQZJMJJDnxm7/IICB9cPKVdGhuipc7WgFswhZSe9z2XOW4gAXw+Bc?=
 =?us-ascii?Q?/PkvXipTA980Ac3Bv6WbsLOn+rflViq2hQNR6xfjz7ydGd27VgeJgdOGszxC?=
 =?us-ascii?Q?4R4GypiHHgGHHvxePbZZGOI3lKTDtkgk50wIJNeS1JX07GtezxRYPJkCy0gG?=
 =?us-ascii?Q?dSzJC8daLMG7/NfUYATb3zw8H1prulCgwdebzN7hFVGcGbDfqQ/i2wBr3qWo?=
 =?us-ascii?Q?1Zkxw0/tsszPwqoR5mDnjbeOGhWEoq/ovYXJMl6X5aUQHBuQJRLyh4niuGsm?=
 =?us-ascii?Q?vWpfuPK9VHSRNKtziweK2oW8qZV8n50ptEo5MTD8aTFEfgpurbinpcXp/c8B?=
 =?us-ascii?Q?XzbvmjuuHmTbxJXdF3I0cXaCif/5376pzylaruq4zXmocdnPCBMrW7m6Motd?=
 =?us-ascii?Q?GDL1GruoVv+NpBYsD0Qg8yjn+ugcHTgvpuQJISN7kx9j5um38zeR+D+TXYtC?=
 =?us-ascii?Q?L1yj8gnqPs7jll2b0nZFZcIDtr9RdQvDzJHqjcutrtmLngIpnEfu7uaGz4so?=
 =?us-ascii?Q?4hb0jy/E/FJ4b2nqnryjVsTqzaHB+fkumn0W3fH0PKWpOz4ANV67uydxiGFW?=
 =?us-ascii?Q?chAc43afyBAnKi1dSaEgFpyiDCR9qO9XeH6gMmv3EhZ3lmAfXu+X22ciL22f?=
 =?us-ascii?Q?8G43NXe6oafy/0kTDUSzXwN0fzvWVxfYK1YR8N/VyD/Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a4b830-cbce-40b0-c0b1-08da85e62ebb
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:34:50.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCT2YeoCCutFQrPLxUTzLXA25HUM4lr3EQ2v/SIk5l/mPXyoitpZMQjX3naTbCLhtTcCaxMYNq0acCmjH05Qvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--otMSDLJUvslt9pFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 04:59:56AM +0800, kernel test robot wrote:
> Hi Mikko,
>=20
> FYI, the error/warning still remains.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   072e51356cd5a4a1c12c1020bc054c99b98333df
> commit: 8aa5bcb61612060429223d1fbb7a1c30a579fc1f gpu: host1x: Add context=
 device management code
> date:   7 weeks ago
> config: arm-randconfig-r012-20220823 (https://download.01.org/0day-ci/arc=
hive/20220824/202208240444.uTBVAbiI-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D8aa5bcb61612060429223d1fbb7a1c30a579fc1f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8aa5bcb61612060429223d1fbb7a1c30a579fc1f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/gpu/host1x/
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/gpu/host1x/context.c: In function 'host1x_memory_context_list_=
init':
> >> drivers/gpu/host1x/context.c:65:23: error: too many arguments to funct=
ion 'of_dma_configure_id'
>       65 |                 err =3D of_dma_configure_id(&ctx->dev, node, t=
rue, &i);
>          |                       ^~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/of_platform.h:12,
>                     from drivers/gpu/host1x/context.c:9:
>    include/linux/of_device.h:103:19: note: declared here
>      103 | static inline int of_dma_configure_id(struct device *dev,
>          |                   ^~~~~~~~~~~~~~~~~~~

Looks like this was caused by a mismatch in the signature of this
function for !OF builds. I've sent out a patch, so hopefully this will
get fixed in linux-next (and mainline) soon.

Thanks,
Thierry

--otMSDLJUvslt9pFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMGRRMACgkQ3SOs138+
s6HPshAAqi8OEMfK1PvIoLVo5iCqRnKMHQoug+xQsoJpvBfW8TI33MIvFHkush6S
IohchefO4wWGXusXXeEHwj4pIKO9AN9JDXL3eyf46oDTei6kq9MUclwL43exZvE3
yZb63E2n2BL6O+sTIMYJau7RuYBtjMtSETRKQRWmb8YfLBubnx5iwAGksp59hG8l
JkO+ToXi+MOPTySzu0plFwTGT6VsWJLdYJFJns3u7s/Bpkoa+th8zQtMevaD41fl
a+tH+vf3EBmEqmgHXGXHLPrEF8cTpY9I07X/mn+jsU4bZldYq/5tKcViQDSANeu5
UtYXYpihqQhrp0C22mh54FFbvQm78U1YoqWjsg3YrEcdBw7ZU2IlbPEV4ggFwHCB
EXUYkzjK9cmv2oEvuMkkUlpsxTvrUb50SKpgHff7Y3kPOLwsz6RiNo8KjkQc2xHf
vSCYpjV4fR0YKLHsCP/iOSZHKCnUMfU9X/pbGwNLxXl9BFLs7zwF/AP3f3jG3yDL
SQuNDPJG6NNV05CoMfNmtgIOoLBCNDCoB4WFQgodhX2J+F5u3ORdx54NXdLYOQmo
v6q0T9fTadjWStK9ygx8SalNDVv6J7z7CZUIVpHJ1q8uZF6zMeO2xIYhlRQNZxzw
+uqop+vi20PU0khCTlXczoPtIm0Lj64DC+NtQcWFTNoAah2zfBE=
=iRYT
-----END PGP SIGNATURE-----

--otMSDLJUvslt9pFF--
