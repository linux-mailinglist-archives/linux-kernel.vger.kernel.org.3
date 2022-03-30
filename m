Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9674EC79C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbiC3PAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiC3PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:00:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45255A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:58:42 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gi14so17075169qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=l5d4z40lcsExb2VcuXpJGK1vARAluV7fagbwarZTvHo=;
        b=i3wQrtlsZyxDiN9PCMMFBwk6hwkW4qMbr0kI+gRHCuZt2hjAMmlZLn+TtYNwcCzbzR
         RnriIJf8hdecoVgZASTAfAXkpg4C6zRRNNJYa+3z2JtCWSpNgZNgD6u2OVr3u1Ku2uFw
         qUpil4rPRL6nLesjdMeiqxPLhintXY8dTEmWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=l5d4z40lcsExb2VcuXpJGK1vARAluV7fagbwarZTvHo=;
        b=BxiyTYR9WkVHqDivnMD5rT8X81BrSFWSeocFz86cGbeXcpNFp/69UQkY58iBlZnPlm
         j1F0UdZr3N4fWeyvop20j3QpT2sPvXA0aI+plOJguwahOUW94ytxZInNiEG405JyR2Vh
         Cq5I6jf0rff+BPwzILh3cAFASScvIZxZ8YLWDh4Cb4A8O2GNSuW5wxgLSSR3w1k5wnZu
         YLoa7F88rOQbp/RAsJtHJtV48Iucq9sWy+/Bq2GShS3er7YrdpGPYoePJ9OuOWSt91tc
         AhnmlMx0TdZ+CN3jasm15BBll1wiJPboNTuE/MJpk2En8kc8acGdU5nOAI57pDrJLx1Q
         BwKQ==
X-Gm-Message-State: AOAM5307vdgXfUb6rUigm+GXaQrcpjiiCPiOjAgrvvu5OnjGf6z/Qqg+
        JG6gtUyhNF9XgG1FHKIMDXYZ3g==
X-Google-Smtp-Source: ABdhPJybcpK5XD9ijSmRBOyHsKoUz1RNAcu8CPLKrgJoV5n1hdx3vJfJMA6Xd27wpue/GeE8eyCPFQ==
X-Received: by 2002:a05:6214:1043:b0:441:1a79:12a5 with SMTP id l3-20020a056214104300b004411a7912a5mr31381389qvr.42.1648652321389;
        Wed, 30 Mar 2022 07:58:41 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:dcc2:ca6d:a437:b3e0])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b0067ec5ecac66sm12731343qko.19.2022.03.30.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:58:40 -0700 (PDT)
Date:   Wed, 30 Mar 2022 09:58:38 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     chenchacha <chen.chenchacha@foxmail.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ipmi: Limit the number of message a user may have
 outstanding
Message-ID: <20220330145838.GY3458@minyard.net>
Reply-To: cminyard@mvista.com
References: <20220329183340.471474-1-minyard@acm.org>
 <20220329183340.471474-3-minyard@acm.org>
 <tencent_508F9F7681360F657D131FF97D2C53506208@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_508F9F7681360F657D131FF97D2C53506208@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:44:50PM +0800, chenchacha wrote:
> > @@ -2298,6 +2309,14 @@ static int i_ipmi_request(struct ipmi_user     *user,
> >   	struct ipmi_recv_msg *recv_msg;
> >   	int rv = 0;
> > +	if (user) {
> > +		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
> > +			atomic_dec(&user->nr_msgs);
> > +			rv = -EBUSY;
> > +			goto out;
> > +		}
> > +	}
> > +
> > @@ -2369,6 +2388,8 @@ static int i_ipmi_request(struct ipmi_user     *user,
> >   	rcu_read_unlock();
> >   out:
> > +	if (rv && user)
> > +		atomic_dec(&user->nr_msgs);
> >   	return rv;
> >   }
> 
> If the number of msg is greater than the limit, the nr_msgs will be decrease
> twice.
> 
> Should it be returned directory?

Oh wait, yeah, I screwed that up.  I added the first decrement later,
after I "noticed" it was missing.  I should add a comment there.
Thanks.

-corey

> 
> --
> Chen Guanqiao
