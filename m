Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235B595DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiHPNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiHPNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CD49B65
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660657990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cwLvE+7vvjB6+1NFKWOguckRF1rIfV2XIjoBVtm20Q=;
        b=PpHtzp0imHei+qHpt9tzMteGOiLkaL8rTecNiNRyny3aEz9XkIn1oxB6QOgWBpSEom6r5F
        KJ4dGzzCyN+FLdyi2iUYGD51CBetaC42hnXJkoQ8ecanSwdkdCnZIf6m1HcnhZX2uj8Zqs
        mNpg8si9l9VGa+oyMFTyDaQ0e6CwAW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-A8STg0lePdyrL44FwBnY9g-1; Tue, 16 Aug 2022 09:53:07 -0400
X-MC-Unique: A8STg0lePdyrL44FwBnY9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57D931035351;
        Tue, 16 Aug 2022 13:53:07 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.9.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B1C92026D4C;
        Tue, 16 Aug 2022 13:53:06 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 4/4] fanotify,audit: deliver fan_info as a hex-encoded string
Date:   Tue, 16 Aug 2022 09:37:09 -0400
Message-ID: <4767361.31r3eYUQgx@x2>
Organization: Red Hat
In-Reply-To: <2d8159cec4392029dabfc39b55ac5fbd0faa9fbd.1659996830.git.rgb@redhat.com>
References: <cover.1659996830.git.rgb@redhat.com> <2d8159cec4392029dabfc39b55ac5fbd0faa9fbd.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

Although I have it working, I have some comments below that might improve
things.

On Tuesday, August 9, 2022 1:22:55 PM EDT Richard Guy Briggs wrote:
> Currently the only type of fanotify info that is defined is an audit
> rule number, but convert it to hex encoding to future-proof the field.
> 
> Sample record:
>   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0
> fan_info=3F
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index f000fec52360..0f747015c577 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2908,22 +2908,36 @@ void __audit_fanotify(u32 response, size_t len,
> char *buf)
> 
>  	if (!(len && buf)) {
>  		audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -			  "resp=%u fan_type=0 fan_info=?", response);
> +			  "resp=%u fan_type=0 fan_info=3F", response); /* "?" */
>  		return;
>  	}
>  	while (c >= sizeof(struct fanotify_response_info_header)) {
> +		struct audit_context *ctx = audit_context();
> +		struct audit_buffer *ab;
> +
>  		friar = (struct fanotify_response_info_audit_rule *)buf;
>  		switch (friar->hdr.type) {
>  		case FAN_RESPONSE_INFO_AUDIT_RULE:
>  			if (friar->hdr.len < sizeof(*friar)) {
> -				audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -					  "resp=%u fan_type=%u fan_info=(incomplete)",
> -					  response, friar->hdr.type);
> +				ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> +				if (ab) {
> +					audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> +							 response, friar->hdr.type);
> +#define INCOMPLETE "(incomplete)"
> +					audit_log_n_hex(ab, INCOMPLETE, sizeof(INCOMPLETE));
> +					audit_log_end(ab);
> +				}
>  				return;
>  			}
> -			audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -				  "resp=%u fan_type=%u fan_info=%u",
> -				  response, friar->hdr.type, friar->audit_rule);
> +			ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> +			if (ab) {
> +				audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> +						 response, friar->hdr.type);
> +				audit_log_n_hex(ab, (char *)&friar->audit_rule,
> +						sizeof(friar->audit_rule));

One thing to point out, the structure has a member audit_rule. It is
probably better to call it rule_number. This is because it has nothing to
do with any actual audit rule. It is a rule number meant to be recorded by
the audit system.

Also, that member is a __u32 type. Hex encoding that directly gives back a
__u32 when decoded - which is a bit unexpected since everything else is
strings. It would be better to convert the u32 to a base 10 string and then
hex encode that. A buffer of 12 bytes should be sufficient.

Thanks,
-Steve

> +				audit_log_end(ab);
> +
> +			}
>  		}
>  		c -= friar->hdr.len;
>  		ib += friar->hdr.len;




