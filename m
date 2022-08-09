Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA758D91B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiHINHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:07:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B5AE40
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:07:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z19so11301451plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CexQjRbk8g4rtv6phdNBChrQIXcYCoIEvqKqjiIkf0=;
        b=Rih+yJI7jNNDuSTco4nc6byh8AZj7WjNWGBfQYTqAjfKO2AHFwQ3QlJDq+qriAPEih
         3J3+39atQkL09N4JMH67IyIHe9obJpHbTJHYjNKpwFh6E/ehuzLcqPJS2TOj0zXq22CO
         6lFxl1wxcq4bWidGef7NUtJv3DDc2ccXkdsPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CexQjRbk8g4rtv6phdNBChrQIXcYCoIEvqKqjiIkf0=;
        b=eWe225x1BuYoBklg2zwvHrRcAAqTLscTLvsSSVFT26gvvcNXJtNCsVQAFI9Mmpi90p
         ChpqXW8YavNEEePtc9CXHQffjZ9DXJKeiJmj2LuryZ0tTwv0o5iGlpwZqVpxxO1t79FL
         1k4Za54qVEPY5GGPV8hJTYDBzv1KcZv0sZxaStRDOYYOwnb8wkXTOjRaUy0uzV9faTYS
         TnmrPLBsfc06i5BRvMA7Z1+VVz4q2lQ1m/1IcbqLdC6P43J/Em/CbdZ5GbKCOoh46HX3
         WOz3lIJ+EkHDvPhHMwhgGBiCbyK1wSdr3Vjj1JUcGui1fNcjYPa7JBXaW10sk+4Uatvb
         TFcg==
X-Gm-Message-State: ACgBeo1H7mK6LDGR64Rh1dTArTX+H7MLc3O/B0rcbS2/RN9WbsydMQSe
        lmERsUrR8u4+5t8yxaAcx77DUg==
X-Google-Smtp-Source: AA6agR61Sa3kvLa6mRM8tScVhtJ/Z7iM09P6FAUVNc+sm8EmosNlIU5jiD/gM44ofrheZ9JJGx9Ixw==
X-Received: by 2002:a17:903:1209:b0:16b:81f6:e952 with SMTP id l9-20020a170903120900b0016b81f6e952mr24413647plh.48.1660050453752;
        Tue, 09 Aug 2022 06:07:33 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm11043190plf.20.2022.08.09.06.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:07:33 -0700 (PDT)
Date:   Tue, 9 Aug 2022 22:07:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvJcD8xB+OepycKX@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
 <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <9fd860a8-4e4f-6a95-5c3f-1b3c4a76cf51@kernel.org>
 <b2662600-07cd-7125-d7c3-b7bbe1bad824@kernel.org>
 <YvJZztvKtedJfeK5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJZztvKtedJfeK5@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/09 21:57), Sergey Senozhatsky wrote:
> This somehow makes me scratch my head and ask if we really want to
> continue using per-CPU steams. We previously (many years ago) had
> a list of idle compression streams, which would do compression in
> preemptible context and we would have only one zs_malloc handle
> allocation path, which would do direct reclaim (when needed)

Scratch that, I take it back. Sorry for the noise.
