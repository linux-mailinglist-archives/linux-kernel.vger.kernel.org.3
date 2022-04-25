Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A850ECAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiDYXgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiDYXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:36:18 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC3C7244A;
        Mon, 25 Apr 2022 16:33:12 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 58D9D3F62C;
        Mon, 25 Apr 2022 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650929589;
        bh=/1sdtvY8PI+ceXq3A+Jws9p0CyudDHL9DGyJljTfMy0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pLYW4C3QtFeU5LfgX3Ue4TXctrT6eKmbEdJwCioGCmB11RPqEiB+Ju2UZ4PzFb8wz
         qQsDpm+EmlzXQfaKpktUklND8RSXP4biR3O4DvPq+g5ZiLiyfZkA9OwCFsv9vyT4rk
         jnTJBGgh355Bl9wRcm9B/akwa8vu/ffIt75/aIE85OJLxw04JcjhZUZt3u1pi1MPSF
         I3Y8xhvntofBikjYWffnP7Op6wzE7mpK9FXBD05RN3cGAvigQkXwoTregHpxKWy6Bw
         JIfGOCX12Q6nUqy8kHq7Xskwauqed/Ht1y/kzJsDttP+3b+LJGRagqbtTo+E3oA/TO
         IMvWgrSRQZF3A==
Message-ID: <a881e6c4-248f-1d00-545d-2b9d3a1005b5@canonical.com>
Date:   Mon, 25 Apr 2022 16:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 24/29] LSM: Add a function to report multiple LSMs
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-25-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-25-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 07:59, Casey Schaufler wrote:
> Add a new boolean function lsm_multiple_contexts() to
> identify when multiple security modules provide security
> context strings.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/linux/security.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2150016492be..3fab84220f88 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -232,6 +232,15 @@ static inline bool lsmblob_equal(const struct lsmblob *bloba,
>  extern int lsm_name_to_slot(char *name);
>  extern const char *lsm_slot_to_name(int slot);
>  
> +static inline bool lsm_multiple_contexts(void)
> +{
> +#ifdef CONFIG_SECURITY
> +	return lsm_slot_to_name(1) != NULL;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /**
>   * lsmblob_value - find the first non-zero value in an lsmblob structure.
>   * @blob: Pointer to the data

