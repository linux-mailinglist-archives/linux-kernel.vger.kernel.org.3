Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50F04F6788
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiDFRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiDFRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:34:48 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356527B605
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649259695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRoNGebNpG+7JCeHgdPg8u/gYAPkrLtJXRhl4RgFQi8=;
        b=HF33rDRg/e848iQNxIU5dQmxHHQjhZRlL51GqXxtZelIKqTMsP/wZ89s+Rtg8xHquNCsbR
        IrHFIRYGUNT8kyLixUMRGD6L/R/Xjb8C/H7wU1YilrPPyMSBlmOkoXXHZHOQwuRg4Esya2
        aNvSB48nzrnZBd87CO5vTO2aDUkSC6U=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-2fhaSZ82PpGnIrYVATNk_g-1; Wed, 06 Apr 2022 17:41:32 +0200
X-MC-Unique: 2fhaSZ82PpGnIrYVATNk_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh9e6JZUNLR0L+uSMRENPiyiYmJywHQbyQabE8T+gCGx3DHy7XGZiLx6Bc2T0yaWhanyWN0ZCpcaS7suLL90AOFYPpc+9jty7PKwp+tftKYtXQ/ezlxoYpVBaOVTpnCDPYxrHYXAcIQrV0Lug5UDBwSFYjAjixRHAT3K4Hn8kmrBvLhD5QYXmEOGv1b7ZWBEWc3sXP/qMCEQcB5HXiSs2HqJJJDKip/gobcILx8D6buJ72PshllFG0jT7LQl0GbgcPL4u6jYpO+GaMdiWXwiwAVjrE9b2456oAjaBAqTKvALWaheGCslvZjXLQX3+OzF0IwJmgziosgj9DwR5VOWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRoNGebNpG+7JCeHgdPg8u/gYAPkrLtJXRhl4RgFQi8=;
 b=IMU4NQRS9nBN0/RWr4DxhjpK0tos5Pwi3rA873BgcYbaSBSgMbwlv4A+aYnYiVDh6wr0FqEA2nW6cNrFiR/9e2izkgfsZ8HnQzRJmCZWSi1QzpURoRGCVYd1SEBsHOvPNfQHfq31b56S0JE644M7z0B8N/tnzh2aRFpcxq3GRgDpp2omdnXNjzstSNavl2iaaMjbTdhIFeW/J262uXwe7rJR1r0vW1XyjIcG+Z1gErxnCYbwgUtVw3fy2QT8yn7iZNvmrYAh3NSUYVYa4cbg/Tg7+YigoaXSz4sPxveqY22GZND3HulGARh4nxQFVBAZMuv5kaNS/XCR9MhRwfMVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by AM0PR04MB4243.eurprd04.prod.outlook.com (2603:10a6:208:66::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:41:30 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227%9]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:41:29 +0000
Date:   Wed, 6 Apr 2022 23:41:16 +0800
From:   joeyli <jlee@suse.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH 1/4] Fix arm64 kexec forbidding kernels signed with keys
 in the secondary keyring to boot
Message-ID: <20220406154056.GL11641@linux-l9pv.suse>
References: <cover.1644953683.git.msuchanek@suse.de>
 <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5afd4a4-6989-4fa3-2229-08da17e3eace
X-MS-TrafficTypeDiagnostic: AM0PR04MB4243:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4243E197FAC4ECB1F14BA618A3E79@AM0PR04MB4243.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzVz3DttFi1aUoKgY/oMT/vkk6zmv1301xgdAsUoYN/diSD+D59HpIoF2jh2cU0EX4xDyiAlht1CGrtVCyj9ZiQV/dT0ZDU25p7cDTcp3O1aCQYvBvR/e/8C5XB3UDobpkAXUNMRFJ9n1b+bRjo5o+itCMqQHZNYhEMcjska6qsTmfxWZBSDq3CKgYHxspzLElJb+o0hn7MXOlabd5FRcBi+Zp4qc2mVXwfPKQkx/L4GzKEB1fIb6n7PaTlLrw+KGcKa/NPipMICaucDH4V428YkWK8BPP+l1+bDS5X65X/FNky2H+3sJziqOjC91GEoYqBA/sUcXRbZiTAP04ZtqHIHCdHozQoOFopvPbPe7MkyJEip9eXdP53Nih5NUJuMGEDA/cdZtn7x1ThW81pyc7gVP5zqCqccTlTq0AngnbQfN2/t0eoVEwPHtchC02wfT/nnE+c+hBuPn5h/iVUYhxRvuZ/genDAARhmO4Y/RIFPEbnOlDeJtKpYlb3qIE4cE5xRkAyfVyYVmXsO8ycBMBgbLEZh9HSgFne2ju/KJj8VncQFxF2FkYDyklSey+kEkHGyMOvH4dDe+ID6KDhJuXdONU9lts8vcc5NTQN/igbV3iZksGt/HOo4EfGJd/JN3m3y0uhdlEJTizpYPnzHp5c63qs9BDDuaLZDSvbmDin3Tc4IJKuEKrKMX4FhBcACYM6G/9285Hn33/1/15w0jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(26005)(186003)(66946007)(4326008)(6486002)(38100700002)(1076003)(508600001)(8936002)(66476007)(8676002)(66556008)(83380400001)(86362001)(6512007)(33656002)(6506007)(9686003)(6666004)(2906002)(316002)(54906003)(36756003)(6916009)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wf985CF6ryCrnDXwjZqmB60ylTzJbxNXAZ+4I+FLnIaK5CmhUYxVLxPHJrWY?=
 =?us-ascii?Q?GdgNhQOBfj9AbUSndc/A4O/rIYkMOej7EJFenZMRRB4DLiN/SsPaRFJhHdUD?=
 =?us-ascii?Q?oEP2qSRaQINXl1nPr2cg/ZkGbcnhXAOgjGePkkYFZYlOKe0G6C71GytnwtX8?=
 =?us-ascii?Q?6PgDnnDw3rRWe9MMLrFH1DQgOwYDeIwwKwlKahu+uTYpAdjeTmW2SnOOO2UP?=
 =?us-ascii?Q?mmVeug9g+ScovVZK78pNl/r5e8GTzKss3QCtaSYVs+Id1rUW515bDs7FoVhD?=
 =?us-ascii?Q?Vx/UIP6nFIAry4Mc1tn6aCf73BOX8EWiXrAMoOlC3Xc+M2q8WyqHAkUtNvd2?=
 =?us-ascii?Q?Z1StpBPzGdjqbQTcHZbst1GnR0LqEj2kgODWTeWUqlv5iPBzqrv5pwVmurFW?=
 =?us-ascii?Q?Wi9p1ywuHfpQgdVdcBeGzn++l9D3qz+ZvE9ytxMbwMswEKHwgywl2tlwW0qN?=
 =?us-ascii?Q?HxuAA/fTVIGL/fltalm6r4IijDsKP7/E3SoP0wpjYFkhc5SUK8wh5U0TOK3Y?=
 =?us-ascii?Q?lLuZB7uMwuUwbOl/eXpcWZoq8+BoJAd0LDY3dgeD027lwXNTnuEVyc10MhCM?=
 =?us-ascii?Q?6GTcTTI7h0JC6UyAmsDceXiP2adHU/sDabzU3FyDfIgaP2p2qjCXehnvNIUF?=
 =?us-ascii?Q?/FQw9nIwFUhpBtgPwjuIaytQ+K+S3/g6/BtS1Mz9A0OCMq5Q5CAI73HuhX+k?=
 =?us-ascii?Q?PJvf3d9X1MrPWbEQOR/La5bqJ2pwKNxBWeZ6m3t86G3T+whvdRyeaBQTI9Zk?=
 =?us-ascii?Q?/wREaM/C/PDptocp50RozvPKVji4L93rBhUb5pkRj0C++mjFcIF0H0Yrf79p?=
 =?us-ascii?Q?vCv28EPvOxnsWsDVm4nbhpIdD7caucOmqshXbL10U9jdJxwSM5PgkR7jNY6Z?=
 =?us-ascii?Q?E3bWAc4QiflPYMyjUEp9YvGPNb4qfoBZjeZbXUolHtQM99VRDQJY95wuwiwr?=
 =?us-ascii?Q?FCUzaeOW78twmoaAgVZOkIRJhmasGn7lTabpTtCinpT1lJf5DhFAj6IH7X1L?=
 =?us-ascii?Q?pvqNyGHLSKGJ4c02N+AfsItS8jGHCdnA33343DhsAN1mOGGB4E/WWAVCLAb3?=
 =?us-ascii?Q?ZFcAAy2o/LSV3fle5nwcnmIUkEj74SiynSySo+rDKO6nU6Hc6peReR7E6ahP?=
 =?us-ascii?Q?YcgxuQtAx35lGxw13FTUE9W4fS301jRn1/gnh9RIazaElS9ZRFLKjAvyZNfP?=
 =?us-ascii?Q?YarE+2klvEtOqxIbQcChAiMkfb3WUonpuwkQx/YdTmKXPaS9UhjPb9NZm36E?=
 =?us-ascii?Q?9lEv5EG4ego968aHQk7PbV7+hoXAiuSedVFCbQkfQC2al1KfzhNqEZjAyfm/?=
 =?us-ascii?Q?o9gjoHYsHWgxS+fp4qqX6AWwXAVfydW7KVwzL/5LzhU4KKtEp6brJ52KD7H0?=
 =?us-ascii?Q?k+PbsPKhwghpbRydAJaXiQMH+c13q7ogu03XKINgqPJRIUheqv70xbxhftL5?=
 =?us-ascii?Q?Mtw36BKshG+/A8jcIMgy7rKkIns/DaGzxLcCD+FLpKzV4a87Bxqb7x4tf/qX?=
 =?us-ascii?Q?9Oteyh7tpy79GlSVE9XOsr6/pB46cEAYATY2SNe9mZ5erpqrKVapYan+hQxJ?=
 =?us-ascii?Q?uHIFWU8mT1MgguLaM1OIT7WPdSd4QGSXnIXIam4nJfxK3KzMpN9Rv8zjJ9BZ?=
 =?us-ascii?Q?eqzjaWVrEJJ6evxTBUXB0sMNYpdujpEVqIU5HXeObURfhQ+uzHU4nGKtXw/5?=
 =?us-ascii?Q?hjNZK7UTIWCJ6kg1By1CvT5VyqNNmImXWsZUT6tyLjvbAVEUqXsInj4MLW0F?=
 =?us-ascii?Q?FTqlFGSFeQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5afd4a4-6989-4fa3-2229-08da17e3eace
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:41:29.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmKKKphQucC3nS9hVpqyEbuEJuCDNLGAuJfVmvlh4vf0O/g8U3Cxn65N9GkuK8F6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4243
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:39:38PM +0100, Michal Suchanek wrote:
> commit d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> split of .system_keyring into .builtin_trusted_keys and
> .secondary_trusted_keys broke kexec, thereby preventing kernels signed by
> keys which are now in the secondary keyring from being kexec'd.
> 
> Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
> verify_pefile_signature().
> 
> Cherry-picked from
> commit ea93102f3224 ("Fix kexec forbidding kernels signed with keys in the secondary keyring to boot")
> 
> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

> ---
>  arch/arm64/kernel/kexec_image.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..1fbf2ee7c005 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -133,7 +133,8 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> +	return verify_pefile_signature(kernel, kernel_len,
> +				       VERIFY_USE_SECONDARY_KEYRING,
>  				       VERIFYING_KEXEC_PE_SIGNATURE);
>  }
>  #endif
> -- 
> 2.31.1

