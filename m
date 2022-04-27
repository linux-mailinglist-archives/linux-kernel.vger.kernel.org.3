Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA2511422
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiD0JNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiD0JM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF51973066
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651050444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlP3askR5SLt3D/mCVopQREcxnxlzFTELhmls5ml/4o=;
        b=cEBeAVxtrpzlaoAdq40g/5/8Jv9uM3NNPf7WvlAHoMo7fqx58h76RIFpg8OcfneJNczTxr
        kzFd7u+PHgQ289qmsizBAMFCUhjEGQ+ValjjqpFYmieYyup9YZzTB654PlCpJiXr4E9h8/
        nh3CFRu4zaz5jjLL7jS8VaUIYl29NX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-4WmW6tzYMVCH1HfXcgfZfA-1; Wed, 27 Apr 2022 05:07:22 -0400
X-MC-Unique: 4WmW6tzYMVCH1HfXcgfZfA-1
Received: by mail-wm1-f72.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso493066wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlP3askR5SLt3D/mCVopQREcxnxlzFTELhmls5ml/4o=;
        b=EyIXzFB3240v97ZlAtwBUSxqjliuDTHNCWyXqGd/zc+Ly/1ZjsXlkL8UrBIloc6R2j
         8ZHuOv5tOF+UxOadGkRahR9RkMa/AwgeUJ8VUuqfuq37RM92gO4ENdJ2h5i9xS27exbT
         6OVmnwkHE9jWulkp/HdEyjGTUqd/OI1f9fm6M9iIllMcPyrxiZFxuXz5IoB9K5/gn1CW
         4RYk7iguDGDAvnebyVU0l+Nym/eLVg5omS5MCPbl8cU05oOnUz6QHgsDuQ33Lyqz9EBs
         ityTDC6JC4KReOhJtK41gmdINoAhO6FH2XqmRtu+GOcaB/7k25qKHAAxE1bU/vsyj2yx
         C7/A==
X-Gm-Message-State: AOAM532y/P9EBmCdZbYmtUtHfMdP5rEWKODRMzDLhsnnrJCkBmUPGzZC
        RaYhdnUtcMbUJoVZUErmmcABpTv2hD/2w5DHA3DlrUDXp1TD3hr2FZosyg98wjcCb2KVaC556WW
        BZz49Badx5NjGcYESIXXQd4Y=
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr11259445wrt.59.1651050441660;
        Wed, 27 Apr 2022 02:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS6PdfRBkjuFq+2OuKCjksKEbdx1UuoLoYLoAqcMXQdqjUwnhJzSb/Jr7tt/piyg/czfgP9w==
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr11259419wrt.59.1651050441433;
        Wed, 27 Apr 2022 02:07:21 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm1302186wrd.32.2022.04.27.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 02:07:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:07:19 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     k@ava.usersys.com, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <20220427090719.qbtjwvde4wwzmruh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <YmcvZQSiu95MUvxI@bombadil.infradead.org>
 <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
 <YmgcXSXTM80/3R8b@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmgcXSXTM80/3R8b@bombadil.infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-26 09:22 -0700, Luis Chamberlain wrote:
> I'd rather see the effort than not, given all the effort to already split things.
> I think it keeps things pretty tidy and it can scale / and its easier to review.

Fair enough. I'll create another iteration of the series.

-- 
Aaron Tomlin

