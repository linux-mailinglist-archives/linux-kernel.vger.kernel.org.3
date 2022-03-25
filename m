Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD914E79A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiCYRIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377278AbiCYRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:08:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A736E6156;
        Fri, 25 Mar 2022 10:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F37EB82929;
        Fri, 25 Mar 2022 17:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDE1C2BBE4;
        Fri, 25 Mar 2022 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648227997;
        bh=K+daBZbkRbuBy3w3JC2sCKDcY5E1te35mjRdAZhUHK8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CPVpPumid3Gdl7SdVD+WIoxFjBd420teMzU1V7BNJumlelHc6V04uoKeavh4E1jux
         TJwYPTZNZQpk6DvSdHyZf/8/quJHuPHN9xxi5Q+zguHYGZM9obFYtBHLDdJu8g6FdR
         z7b+5YumNhW4MbrnargLqZ3OFKo2AcWvZWvFIscbNp3kfKcmBZW42HFOaGwjln9CfT
         xfnCrZtTlXd4p0ANPIa/cisPUw59RsOa+/M4hHIYs/PHJJGnspvyvpIsOh/qDPdCRz
         1IcUUU0Mf4xRB1nX02m1blYDsv+jcqGzRE6x7Xr3Tswb6bE2YLi8PR6khZ1sumeK5D
         QIdaH/MQzpQvg==
Message-ID: <e81281e69aa29cc10241bbff60283ca7baed87ea.camel@kernel.org>
Subject: Re: [PATCH] ceph: support legacy v1 encryption policy keysetup
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Mar 2022 13:06:35 -0400
In-Reply-To: <20220325164947.22062-1-lhenriques@suse.de>
References: <20220325164947.22062-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-25 at 16:49 +0000, Luís Henriques wrote:
> fstests make use of legacy keysetup where the key description uses a
> filesystem-specific prefix.  Add this ceph-specific prefix to the
> fscrypt_operations data structure.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/crypto.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index c2e28ae54323..2a8f95885e7d 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -77,6 +77,7 @@ static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
>  }
>  
>  static struct fscrypt_operations ceph_fscrypt_ops = {
> +	.key_prefix		= "ceph:",
>  	.get_context		= ceph_crypt_get_context,
>  	.set_context		= ceph_crypt_set_context,
>  	.get_dummy_policy	= ceph_get_dummy_policy,


Good catch, thanks! Merged into wip-fscrypt.
-- 
Jeff Layton <jlayton@kernel.org>
