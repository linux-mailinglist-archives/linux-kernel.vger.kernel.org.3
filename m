Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAA529866
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiEQDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiEQDop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:44:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE646653
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:44:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso1221020pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiOpix41GB5BHq08iCoL+4J7NeWeXx9NRhdLIRrYo6M=;
        b=JnuaI49VgF6nFsSKPtNL++ozMVIxOTAB5Dxq74d+ROFsma5fB6GC4kR3iwAgyhwB/g
         upJKL0belC1JZAh4Ep2TmHbLJ/Ih8JvmN1GMHHKxljoawGhdw5u3IPbp1WQSTIEEkarE
         pCxp6+ifwXStfVodBc2ecbpvj4++bWVm3GqP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiOpix41GB5BHq08iCoL+4J7NeWeXx9NRhdLIRrYo6M=;
        b=l6JbBanYa20aO7cM257nIXMATzX5g6m1G2AUlZaSP3Gkh+ighAkoSQFUjsROgY9zif
         gOyYHmpOy7y0mwtdu+FkIhVNOFcMijMUQv02YhJQo91lww7zreh8C0uWBLup+cDTyzT0
         JQ17Kc84cUnS5zWDvrJ8GNj/hxOKsNmsIH+AUiNjpJcgX9vOMZvbXZQDJ5KmxAYktZAo
         gVOwPblOdcNhaH+c3Em/Oib7LU1SIa8Y1s+qVSKBhF4pEdis8cTAKzElMWEtqkl4CLhE
         FvfDn/lh97Dcu88qtH6Pp04v+sy77KkMpdBm04OuEb0fGs2l6d++TTMHVS0tcwkhj1PT
         7PnA==
X-Gm-Message-State: AOAM532gGbglWU1oQoKoHINOJivreOjUc2BfQSFCY5bevPFnhnf/e+f+
        7KAuzQlGzU9xfRlJEF95DwgcUwZnBgiwdw==
X-Google-Smtp-Source: ABdhPJw2bzLqlq4aNLrLxAfJaNPzwLT5uJMUgBJTkm3oE4Bw5SRZ+uHA67xhyevEZEYXntRBkoyFnw==
X-Received: by 2002:a17:90b:33c6:b0:1dc:ba92:41bb with SMTP id lk6-20020a17090b33c600b001dcba9241bbmr22600450pjb.26.1652759078847;
        Mon, 16 May 2022 20:44:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a990800b001df6216e89dsm458974pjp.28.2022.05.16.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:44:38 -0700 (PDT)
Date:   Mon, 16 May 2022 20:44:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202205162038.B2D1BBAB3@keescook>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <B7FB2BE6-DF1C-414A-B4C2-0C15FD1CBF75@chromium.org>
 <YoKVSEJyHvFg/V9+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoKVSEJyHvFg/V9+@google.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:17:44AM -0700, Matthias Kaehlcke wrote:
> On Fri, May 13, 2022 at 03:36:26PM -0700, Kees Cook wrote:
> > 
> > 
> > On May 4, 2022 12:54:18 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> > >Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
> > >devices.
> > >
> > >This change adds the concept of trusted verity devices to LoadPin. LoadPin
> > >maintains a list of root digests of verity devices it considers trusted.
> > >Userspace can populate this list through an ioctl on the new LoadPin
> > >securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
> > >a file with verity digests as parameter. Verity reads the digests from
> > >this file after confirming that the file is located on the pinned root.
> > >The list of trusted digests can only be set up once, which is typically
> > >done at boot time.
> > >
> > >When a kernel file is read LoadPin first checks (as usual) whether the file
> > >is located on the pinned root, if so the file can be loaded. Otherwise, if
> > >the verity extension is enabled, LoadPin determines whether the file is
> > >located on a verity backed device and whether the root digest of that
> > 
> > I think this should be "... on an already trusted device ..."
> 
> It's not entirely clear which part you want me to substitute. 'an already
> trusted device' makes me wonder whether you are thinking about reading the
> list of digests, and not the general case of reading a kernel file, which
> this paragraph intends to describe.

Sorry, I think I confused myself while reading what you'd written. I
think it's fine as is. I think I had skipped around in my mind thinking
about the trusted verity hashes file coming from the pinned root, but
you basically already said that. :) Nevermind!

> > >+static int read_trusted_verity_root_digests(unsigned int fd)
> > >+{
> > >+	struct fd f;
> > >+	void *data;
> > 
> > Probably easier if this is u8 *?
> 
> Maybe slightly, it would then require a cast when passing it to
> kernel_read_file()

Oh, good point. That is a kinda weird API.

> 
> > >+	int rc;
> > >+	char *p, *d;
> > >+
> > >+	/* The list of trusted root digests can only be set up once */
> > >+	if (!list_empty(&trusted_verity_root_digests))
> > >+		return -EPERM;
> > >+
> > >+	f = fdget(fd);
> > >+	if (!f.file)
> > >+		return -EINVAL;
> > >+
> > >+	data = kzalloc(SZ_4K, GFP_KERNEL);
> > >+	if (!data) {
> > >+		rc = -ENOMEM;
> > >+		goto err;
> > >+	}
> > >+
> > >+	rc = kernel_read_file(f.file, 0, &data, SZ_4K - 1, NULL, READING_POLICY);
> > >+	if (rc < 0)
> > >+		goto err;

So maybe, here, you could do:

	p = data;
	p[rc] '\0';
	p = strim(p);

etc... (the void * -> char * cast in the assignment should be accepted
without warning?)

> > >+
> > >+	((char *)data)[rc] = '\0';
> > >+
> > >+	p = strim(data);
> > >+	while ((d = strsep(&p, ",")) != NULL) {
> > 
> > Maybe be flexible and add newline as a separator too?
> 
> Sure, I can add that. I'd also be fine with just allowing a newline as
> separator, which seems a reasonable format for a sysfs file.

Yeah, that was my thinking too. And easier to parse for command line
tools, etc. Not a requirement at all, but might make testing easier,
etc.

-- 
Kees Cook
