Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7A4FC251
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbiDKQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243264AbiDKQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:30:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADCF2E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0rQpAwkztBzMbf7heO6K6EeM3mtFb2cjp7kOX4piMzkJq9HSzjkV1xqCEoQf2xzejvcwENl395QLLvvzsj98W1jDIhLoSlFnPvbUsEJ/3wuYOgbYOLWSRVuwI7RH94yHzc4gi1XJh1RMpaOugqnETVjQn3DFFkf+SSKPEJobpy7INpuZi46fc/QJOM7pDvXNmX2w2nMUb6edIlwFkbpephD7JNQHSzpuNQTRlXaExPoFsZnd3Y9wPahIqC7oJy4MCESySk2WTYNm85GBeVXLweA6qgXPpPbuvQW0JbuUceOo9KNZxt4JCJcRSBpZnZ0YZdINOPNbHW5vt7sljIbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNnfVw36FV0r8MhKaSXh76eaQuyeqIAbdpgye6FVIQ0=;
 b=bacEL372xYzzr9hfuHJVUnQYv4j8BvJVjA6RF7hvrNn4IPWDgpQl9M+4DPSHhg1p5PxmoEf8euUGaSCZzCkKNNBa/Q+eLTqP5B0mN+jp0xnyCjdEJWhJ8DyOik5jdyT3XzwpyT4vojXGVQ7jT/s3J7vjTK7eMBQYR2UDtGVc8MU5i8Ibk9vSuzyGRNsqrdIdvuWIwPZr7s6UseOliuI9lgc3ZNRJqBRR1u0vhieiXYiN8yII6xkT5Ds/AWcaZqfwnny+Rc7q+iEHIQWwgGl0t9QnYZBRUD1MUyrvlwAs+HyNUccA1n9BdxbHWHEj9JnKklwaZx6XBGrqm4axeZqT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNnfVw36FV0r8MhKaSXh76eaQuyeqIAbdpgye6FVIQ0=;
 b=G16qWVHqZvU00gS1cI1HB+JqWXrtDAPD0+dTl3UaQPKCc04RW7xTqs9xpUudM00Zcx5WuOz9crJmgIErXdOX5xnZ4BCsfSJsUPAyvAHoIRv8pA31NNGHifHJsZ0lGuWfZ1Radg/U0fwqJs75+e9/BGwwUUyvQ69NBwZVPNuHThhUVJEpAMO1zPmU5Lkfciq7K42GM2g3Jbwkt9ZUJTcC3r7eAc45vmJigkWoOqpA2jWJgMVhjB9q0mLm7/WfKOn2t2DYf355g16oFd0xp93RMnoGDRGfU2v/+oPviFkLgHUPzLn5e+7RwUHuMTG0+1MERxYaNGRDHY9urmkN2dXr8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:28:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:28:30 +0000
Date:   Mon, 11 Apr 2022 13:28:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/34] drm/i915/gvt: devirtualize ->inject_msi
Message-ID: <20220411162829.GS2120790@nvidia.com>
References: <20220411141403.86980-1-hch@lst.de>
 <20220411141403.86980-18-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411141403.86980-18-hch@lst.de>
X-ClientProxiedBy: BLAPR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:208:32a::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4468119-b9db-4051-e321-08da1bd85096
X-MS-TrafficTypeDiagnostic: CH2PR12MB4038:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB40382426105D544651EDCCE1C2EA9@CH2PR12MB4038.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKNt0bhiGKdgq0/kxg8Qt6r6mMnf+u0e8r63bHiStbrH/Qu5Xyq1oWmpKE4/cK3naoAKBX0VxSCMIqKbZ4wjXcqOLhjm/o1bX9XR1KURnVFX0he76V/dyBoCwlXNeLOdXDdtrbZ60/cWDdlQpJpA+f/P5+ygCCGpoV7fQVEsyH/Itoi48fNHonVJT032+G1mTNhVShLb1+TIsDb5HvMdvVg3kppiTxu0MFdH5vPk6Z0G2oCnZVH8p/DJgAJqB7/hXMmKkeAbHmkp6GZbQneMyYeze9X2moItTHntpy6cr5e0A5RJIy7ylEVprEY+9suBz7tjqdGj1s7tfaiQ3qULCj8ARKjQlndlF09Rh7ov/0YDc7ReQgbqHXWlBQ+RtltdS4bfM6SVJUxfA14gHorLQG8lWXYrmLB28u0/5gx7wuxgaKAld7BCFXvyGh2ZttyJI0FmoGsd3fl5dCJgvpCSsZ90jngEK7RPGjm0In95+lMeBRM8OJBJEt4/doGN0qi05dWpxMc3K1RId56xWEXYgW5GDJAJtLT2Whhg73dJARYglkXqGyYONQfuZsah8/8yzduD1MDE//Z/mxP+0Z49URUcKoaP7pqXmePkmwNsOWi/7r6lTFnqQmUoTDL/nfaxkvEYYCA/cW6XsmRMdNpBZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(36756003)(5660300002)(4744005)(6512007)(186003)(83380400001)(26005)(7416002)(316002)(8676002)(86362001)(6486002)(508600001)(66946007)(4326008)(2616005)(1076003)(38100700002)(66476007)(54906003)(6916009)(66556008)(8936002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25wGgxZmcv0rTHdrQHPxcPsyLEl/+Z43U1IeM4Oh5nKt9Zx9arWXd0mev0qS?=
 =?us-ascii?Q?/odUcKMPF3xnzh6ZGb1RyNe3W3EcSH5kWFUdBc5PMwNGjgU1q3BWp5v6Z1pH?=
 =?us-ascii?Q?Iv8Iol3kyggEeQcj2PuHeTMncznXOJgTP9z3KvpOEuTFDDElMf9d9XRQOMeV?=
 =?us-ascii?Q?CPXqeLb0gcrBTCQV9izhQErBar7YrIT6821Kbli5yEzS7KGAGDA6wu/gUVP0?=
 =?us-ascii?Q?pkLTgxOY9ALGldo/5W3r5jGt3dzXZmpE+ElhyAuavsig4ruQCmyALhTyeVcJ?=
 =?us-ascii?Q?4qYY0MZ/NM88GomHzMiQIokkHlU7fYXjiJMhc47VX0PkDPHUtpYPP1DLEt/1?=
 =?us-ascii?Q?WurBd1KbEnJLh1G2BkxlReaPAU0cX6Sb9Z25VZIpCIuSQJtLGmJ8T3l/NPJ3?=
 =?us-ascii?Q?2Um3AX8tqL4vI9NnfxjORPxVvdkJMvGPpfJugmmfbWF4x+lgi7o5uJoXrDFX?=
 =?us-ascii?Q?d8QhQRPd1EjaWeLPRxC8HCqngWBsuGuc7AXGKpJEJttmCTcty6C+X8DNP++l?=
 =?us-ascii?Q?3aVcTvO8mITUXScd1GkcpypMz8pA/sD7FPUL2+rhbvyQdbIE4FMW+AhahSXV?=
 =?us-ascii?Q?hJEo6CgcihigzumM7YDcmDx/gM1lUc3aR1iNK/CA+K0dXPy+Z0WYRKrSp9VJ?=
 =?us-ascii?Q?SdqHeZO5fI+LhCBw2/dq+/KjFFLDqxPIbm3Yl+v3teKlQ/Zry0okRRhKpAd0?=
 =?us-ascii?Q?Wm/v1vIWsh3156B/2v7sSAPg0KXOzN1cD8T1GFp1DvWXk1gHDRzxf6mRwvFy?=
 =?us-ascii?Q?MX4a1r+IuMkLhV/ImgEs+Vw7R66yL+6AfWfB92XcvSCEux1MMHeXICdx9KaN?=
 =?us-ascii?Q?moksLDNeCK1w1m3lgRZcSyUE1e138ua99LrJsCmALeT9vzCaOBuGgsnXYP8f?=
 =?us-ascii?Q?MLlLgVL5kfkrNEh8G3t6xLNRmK+Qc6HBNjNQuMrPxesejcFrHUsFK+59JmFg?=
 =?us-ascii?Q?OLUVVbyWjVERJbBK8WmnZVNlLNEr85e+2oOhNgSyQIQyRtqfw445rxQPINiY?=
 =?us-ascii?Q?WfbxHvIwYE8kZZYiiWnCmIiMwNHNrrNpX5aSt4VSq5gxeM0F/Ubhpw8gRnZC?=
 =?us-ascii?Q?3fZ0KzzRfo01AVtMhB2LXelxrKbi0Wkx3dA1nY67qgcbtRgbew4xs0DdNLVC?=
 =?us-ascii?Q?Bon/sDhBuZZXr0+yRD6afccz0tm7aqh022JTL7mUff5xVryAKX03GH/C+OjZ?=
 =?us-ascii?Q?E7iNyxJbyg4+RYVicKjhG6N3Ld5s5R7kGtgTU2sdHJ6/tlIGByWNYa+99qt4?=
 =?us-ascii?Q?6/IJ/LQmKvPnxVqak4bfVJ0F46oOHyU0fofSJb2YDSX83ogYcfZIi/WBKtXJ?=
 =?us-ascii?Q?vsNk6hILa9dExlcBI93l0ars/q5PVTKpHDbPcb+5NqX5FKkGVeYl8xt7MdvQ?=
 =?us-ascii?Q?6JL69VQuAj4LsWukVhJZB32zTIj9fDDomdcV9d+ShF8oJvg+uyEvSAs9slLO?=
 =?us-ascii?Q?wBWnmxpvj+CBbmkvmiKsCXeQsfE17H+RA6UAvDFiKRbRf6OfpKeqpKP5NK+y?=
 =?us-ascii?Q?rb/6LkOs6Ox3N3uQLX8Q7TzbUF4LGhWn9fi5Yk5nsH3cK10sya5V8GZ/k+XK?=
 =?us-ascii?Q?PfNSQ4BMAiyuIStJibM7JbuM/o2/B9Mmzl9k4s/g1d6moRHn8Drkc7LPun+3?=
 =?us-ascii?Q?wPFTuqoih0FJlQ1YnJcaO/Xdi6URDtnsmPvTh4otiq/vHHxMHKbszXIfkETt?=
 =?us-ascii?Q?rZkp/56aUIlTPQh6XKIwfbYbQsaWRpCZLwnMBm26QUGd+hRSiylRzaDtndKj?=
 =?us-ascii?Q?W/tlSGn53g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4468119-b9db-4051-e321-08da1bd85096
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:28:30.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTqh4c+xZqY6Dcwme7Mphdomg4cxfC41i6lbIsKphwMf+B5QNU5PsZQWw4KXQ6us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:13:46PM +0200, Christoph Hellwig wrote:
> Just open code the MSI injection in a single place instead of going
> through the method table.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
>  drivers/gpu/drm/i915/gvt/interrupt.c | 38 +++++++++++++++++++++++++++-
>  drivers/gpu/drm/i915/gvt/kvmgt.c     | 24 ------------------
>  drivers/gpu/drm/i915/gvt/mpt.h       | 37 ---------------------------
>  4 files changed, 37 insertions(+), 63 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
