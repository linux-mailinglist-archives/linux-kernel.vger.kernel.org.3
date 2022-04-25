Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B950ECA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiDYXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiDYXfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:35:15 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B656D3AC;
        Mon, 25 Apr 2022 16:32:09 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A8B6B3F62C;
        Mon, 25 Apr 2022 23:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650929527;
        bh=37RT2Gxa/Ye1KUZxv0+gJqpDi1jYOdYJ7QppPkL8Dug=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dqOdzcPtIr9P6Zjcv//FuUiVDh7avdcYftvc7cvxXCjw8uDiwYGaRLK7BfG9Mf8ah
         p3AmVnQXrO6TswcEBpfUt0FNGfYlK6ex+dx5zr+95PkKWb6HAGAtLnx+gNLn03kw1O
         NuRO3VE4may+zyrOS7ekbZovRuLvSG3cHecEvgajJyh5noQft4o9GYpuctDXeDGYBw
         JMuhWvlRmxClRh9jDc3PEAxoGuL//EXR1DloZqDLHIWoWMxrfU7e96C9/GNWQa6b5w
         yEyfcf5zNvh+ycoiku5vwxAlqTSICe9svVOM9Z3ml+5llZhynkARHo05F21rGUnvJE
         wG6qyu5emBBdw==
Message-ID: <c196795a-910a-1e70-4809-c96717767e39@canonical.com>
Date:   Mon, 25 Apr 2022 16:32:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 22/29] Audit: Keep multiple LSM data in audit_names
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-23-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220418145945.38797-23-casey@schaufler-ca.com>
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
> Replace the osid field in the audit_names structure
> with a lsmblob structure. This accomodates the use
> of an lsmblob in security_audit_rule_match() and
> security_inode_getsecid().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/audit.h   |  2 +-
>  kernel/auditsc.c | 22 ++++++++--------------
>  2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 316fac62d5f7..4af63e7dde17 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -82,7 +82,7 @@ struct audit_names {
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	dev_t			rdev;
> -	u32			osid;
> +	struct lsmblob		lsmblob;
>  	struct audit_cap_data	fcap;
>  	unsigned int		fcap_ver;
>  	unsigned char		type;		/* record type */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 231631f61550..6fe9f2525fc1 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -700,17 +700,16 @@ static int audit_filter_rules(struct task_struct *tsk,
>  					 * lsmblob, which happens later in
>  					 * this patch set.
>  					 */
> -					lsmblob_init(&blob, name->osid);
>  					result = security_audit_rule_match(
> -								&blob,
> +								&name->lsmblob,
>  								f->type,
>  								f->op,
>  								&f->lsm_rules);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> -						lsmblob_init(&blob, n->osid);
>  						if (security_audit_rule_match(
> -							&blob, f->type, f->op,
> +							&n->lsmblob,
> +							f->type, f->op,
>  							&f->lsm_rules)) {
>  							++result;
>  							break;
> @@ -1589,13 +1588,12 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 from_kgid(&init_user_ns, n->gid),
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
> -	if (n->osid != 0) {
> -		struct lsmblob blob;
> +	if (lsmblob_is_set(&n->lsmblob)) {
>  		struct lsmcontext lsmctx;
>  
> -		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " osid=%u", n->osid);
> +		if (security_secid_to_secctx(&n->lsmblob, &lsmctx,
> +					     LSMBLOB_FIRST)) {
> +			audit_log_format(ab, " osid=?");

is there something better we can do here? This feels like a regression

>  			if (call_panic)
>  				*call_panic = 2;
>  		} else {
> @@ -2297,17 +2295,13 @@ static void audit_copy_inode(struct audit_names *name,
>  			     const struct dentry *dentry,
>  			     struct inode *inode, unsigned int flags)
>  {
> -	struct lsmblob blob;
> -
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
>  	name->mode  = inode->i_mode;
>  	name->uid   = inode->i_uid;
>  	name->gid   = inode->i_gid;
>  	name->rdev  = inode->i_rdev;
> -	security_inode_getsecid(inode, &blob);
> -	/* scaffolding until osid is updated */
> -	name->osid = lsmblob_first(&blob);
> +	security_inode_getsecid(inode, &name->lsmblob);
>  	if (flags & AUDIT_INODE_NOEVAL) {
>  		name->fcap_ver = -1;
>  		return;

