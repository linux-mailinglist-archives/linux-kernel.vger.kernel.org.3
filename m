Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA04AB0C9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245760AbiBFRAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiBFRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB95BC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644166813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gr+rlvFHZLc88iZxU30W/q3Yu4fbVb5uGtYcLcCB13U=;
        b=fcScNVmCuOXsYbNelq++RemRDOlmuQCxpTgo9h9KXMyFiZHM/ukaghpRO2+4vb4feiHC0R
        BNfwXpfkQiUiPmvgxvrgLkYvoUcvml0OoPSFdGeILxXQWfu70q2VWgdMfSedJqoB/virkh
        21b8IQqn76ae4KHAQOHUDcro3TK8cHI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-ADze2b0WM9CaP0chAMKHXA-1; Sun, 06 Feb 2022 12:00:11 -0500
X-MC-Unique: ADze2b0WM9CaP0chAMKHXA-1
Received: by mail-wr1-f69.google.com with SMTP id t14-20020adfa2ce000000b001e1ad2deb3dso3810830wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gr+rlvFHZLc88iZxU30W/q3Yu4fbVb5uGtYcLcCB13U=;
        b=FYdd9uM/fQgep+qA3Iw9DTgTm1ZKmLJ3bgo0AU6mXQGrIu2GxKoh6pcSYcLFQ/nj3P
         dgfwZfkeRnGqKVQSz1iAtyNUbxL3+N2+ojhA1OOGj+FUZCQrbzUeDCAQmpt6U+hweFik
         YLI6rqXdiYbHeUnqntUzaxJiJH6+R1pdzGfhgaKOBXNcc1GQrgHlHgH9vSroCMqou7hC
         UPUl3yjH0mTt81hLNq6gRCMmpbIv/EmCEwJgGWnGRDFnLApWBg5IuQhfRT3M6KfUZTRV
         EYZ/uwABabt6GRSIrnbg1m3AL2u56StxlbzSUHxBOmyPwf2HwfKYBC0peTDjWYp7wiIz
         QwcA==
X-Gm-Message-State: AOAM530kq+EKQYWg8BfSN6YQGmfr5ffpoyL1JMBq9CsLroIqL7Aq0Bvv
        rrEyzCV8bxd8SjV5pg7sVlHJt8YhZxFPPwo2KDAd0UKTi5gqWUXvLDNeyJTROwomy9cL8+dTP+p
        5gJZ6SX6/ISlQw54zDFtncIc=
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr7120746wrz.2.1644166810639;
        Sun, 06 Feb 2022 09:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvmFZ6FmoMqKj+jRzNF88xYXp8uy84SvUPF3XkmfOUrST3yD/G26iHFSaMCzsUFgWkG8uaVw==
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr7120721wrz.2.1644166810387;
        Sun, 06 Feb 2022 09:00:10 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b10sm4980698wrd.8.2022.02.06.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:00:09 -0800 (PST)
Date:   Sun, 6 Feb 2022 17:00:09 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com,
        void@manifault.com, joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206170009.exz5slme7drxqyoa@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <Yfw2nm5X+8jRic0C@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yfw2nm5X+8jRic0C@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 12:10 -0800, Luis Chamberlain wrote:
> Linus now merged the fix in question, just be sure to use his
> latest tree, it should include 67d6212afda218d564890d1674bab28e8612170f

Hi Luis,

Sure, will do.

> If you can fix the issues from your patches which Christophe mentioned
> that would be great. Then I'll apply then and then Christophe can work
> off of that.

All right. I will try to complete this shortly.


Kind regards,

-- 
Aaron Tomlin

