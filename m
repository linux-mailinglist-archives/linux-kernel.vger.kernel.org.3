Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A95A8E42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiIAG1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIAG1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:27:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDA10B962
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:27:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 76so16601905pfy.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LUpbwDphPvtED1QTi1ZPW1+S2RNACcn+wb6hlFtY8XY=;
        b=WWTU4lWTW/7wYi2qJpDzYN8K/NLpv7PlWS5uBAJkKppb81ks8aUuyIiL+aXKUp7YnF
         YocMSdrWOvhufrkb5kbh/9BZJjVdEzZnGqmd7AB9AVSuhB8lMWZtfoVTtl6TvHeZJ81O
         bcvx1UIUBnuqv3cP2vYFz0K6ohytRF3RkufYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LUpbwDphPvtED1QTi1ZPW1+S2RNACcn+wb6hlFtY8XY=;
        b=IrSNm53WvOHT+/ZW+Jf61W2RLpEel37V60zbsmrZyZSdpnpymA+X/FOiKRNdPbzPYv
         6edf1h/j+WugcJgw2EG+6bCpzktMCugqQWJw6DarrOGNlzz/zTfOJu1mPM0kH3qU9ELn
         ExUZGbnkdYMhElDJUb/zmLSeoEUGDEmmBHYaoFNxERHytld2Xi9vE59r8cGhVLPWNJUf
         RLwEAa1Nxo71PJUTcOZOBxAvdvDpa8x6eByA+HTvPrxkYPNd16ECt2pf+4Q91S1Z+Tbx
         j7Wj7jCwVe2ZUK6cnY7YbDfukE8IppdKKidLjmxUDoglZ0p5OGWSfWzeYEfIDjOEYGnP
         uGwQ==
X-Gm-Message-State: ACgBeo3qsPV8RQ5mO8oTBblaz5Rp0l6/ttw++lboIllpKb1++HHIqzcP
        +RyPGhIob8TWnF/Tk6wFbELINvOF2YRVcA==
X-Google-Smtp-Source: AA6agR5Ky2h+fMYEWE96VBtRDKYJx75ceGIbNnAxgjJV3/KyA3d0lDG2E0gucajihCuxLu510+QrZA==
X-Received: by 2002:a05:6a00:a82:b0:530:2f3c:ec99 with SMTP id b2-20020a056a000a8200b005302f3cec99mr29438360pfl.53.1662013631087;
        Wed, 31 Aug 2022 23:27:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm12816467plb.25.2022.08.31.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:27:09 -0700 (PDT)
Date:   Wed, 31 Aug 2022 23:27:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        syzbot <syzkaller@googlegroups.com>,
        Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] netlink: Bounds-check nlmsg_len()
Message-ID: <202208312324.F2F8B28CA@keescook>
References: <20220901030610.1121299-1-keescook@chromium.org>
 <20220901030610.1121299-2-keescook@chromium.org>
 <20220831201825.378d748d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831201825.378d748d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:18:25PM -0700, Jakub Kicinski wrote:
> On Wed, 31 Aug 2022 20:06:09 -0700 Kees Cook wrote:
> >  static inline int nlmsg_len(const struct nlmsghdr *nlh)
> >  {
> > -	return nlh->nlmsg_len - NLMSG_HDRLEN;
> > +	u32 nlmsg_contents_len;
> > +
> > +	if (WARN_ON_ONCE(check_sub_overflow(nlh->nlmsg_len,
> > +					    (u32)NLMSG_HDRLEN,
> > +					    &nlmsg_contents_len)))
> > +		return 0;
> > +	if (WARN_ON_ONCE(nlmsg_contents_len > INT_MAX))
> > +		return INT_MAX;
> > +	return nlmsg_contents_len;
> 
> We check the messages on input, making sure the length is valid wrt
> skb->len, and sane, ie > NLMSG_HDRLEN. See netlink_rcv_skb().
> 
> Can we not, pretty please? :(

This would catch corrupted values...

Is the concern the growth in image size? The check_sub_overflow() isn't
large at all -- it's just adding a single overflow bit test. The WARNs
are heavier, but they're all out-of-line.

-- 
Kees Cook
