Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343B517A2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiEBWse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiEBWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:48:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2551E0AA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:44:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so582119pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Pev6TadqoPCvCslhpANrkqa0tRzANTdzEtaxAf0Hbw=;
        b=IO+ItVxTbHRREuluGK2fhmQblF4cgW5vavOTKIpFPkRROJX9gmuVnnXRYdROnlh0zK
         5E/tkPZJOY5b9uCPVSTrQo5ZT1qEvx0sCk9u5l6zkQG9tJNfyrMIAV++5Lw/q2Ftl4OP
         5q5eBsfs5slcB3cSP6ZXkHWEyjFQtO83O56Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Pev6TadqoPCvCslhpANrkqa0tRzANTdzEtaxAf0Hbw=;
        b=JkxuA7Kj5GsXHcOkWj/TFpTc7w8LfEeODlQHHWOMjkt6amGKwczFfjxdUgpUiD6Nm/
         /JbJZO+LjnIomrhr2C7EicBuUpXwlxJwT0ZjU/StBJ4FKBPVj75uU7i2jGsCjWQECukd
         fO34Ye30VQHwHd2uF8q0W+GqokZ13a7DYdr2Fhaqgmi4cTPLA3vnqeHjq1r4kFWBLOnq
         gpylmA11pIG/vW0x8MLw3a36XYW4aZDYmlBkPmbA8rHwnKlFYAo7AZt2CvkGTONZz0LN
         4fsD3NqParg/EtJbaj+LwqjmIAc6QT3CaCki9J/lxxfHqq7FVB+a2fzciv0s7HymczYA
         QOtw==
X-Gm-Message-State: AOAM532+LqbUbyLlYnBkESfF3hSmevHYZLaenj7+XLkU1Cza4RgqAwyP
        Pxn3attDSvRnhd51RPbNU8g5Pg==
X-Google-Smtp-Source: ABdhPJxhVHtiibpNcHj8mIUaI5q3jvfhB3UxBy63zLm72g4zQPjmd26WW0fmoc9EkpEka6ka3qUucw==
X-Received: by 2002:a17:902:d4c2:b0:15e:abd0:926f with SMTP id o2-20020a170902d4c200b0015eabd0926fmr4925055plg.129.1651531497972;
        Mon, 02 May 2022 15:44:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1e1a:955c:a9ca:e550])
        by smtp.gmail.com with UTF8SMTPSA id f3-20020a17090a654300b001d26c7d5aacsm218470pjs.13.2022.05.02.15.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 15:44:57 -0700 (PDT)
Date:   Mon, 2 May 2022 15:44:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YnBe6K72iKSDSqk9@google.com>
References: <20220426213110.3572568-1-mka@chromium.org>
 <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <202204302316.AF04961@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202204302316.AF04961@keescook>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 11:21:54PM -0700, Kees Cook wrote:
> On Tue, Apr 26, 2022 at 02:31:09PM -0700, Matthias Kaehlcke wrote:
> > I'm still doubting what would be the best way to configure
> > the list of trusted digests. The approach in v2 of writing
> > a path through sysctl is flexible, but it also feels a bit
> > odd. I did some experiments with passing a file descriptor
> > through sysctl, but it's also odd and has its own issues.
> > Passing the list through a kernel parameter seems hacky.
> > A Kconfig string would work, but can be have issues when
> > the same config is used for different platforms, where
> > some may have trusted digests and others not.
> 
> I prefer the idea of passing an fd, since that can just use LoadPin
> itself to verify the origin of the fd.
> 
> I also agree, though, that it's weird as a sysctl. Possible thoughts:
> 
> - make it a new ioctl on /dev/mapper/control (seems reasonable given
>   that it's specifically about dm devices).
> - have LoadPin grow a securityfs node, maybe something like
>   /sys/kernel/security/loadpin/dm-verify and do the ioctl there (seems
>   reasonable given that it's specifically about LoadPin, but is perhaps
>   more overhead to built the securityfs).

Thanks for your feedback!

Agreed that an ioctl is preferable over a sysctl interface. I wasn't aware
of securityfs and prefer it over a /dev/mapper/control ioctl. Ultimately
the list of digests is meaningful to LoadPin, not (directly) to the device
mapper / verity. I'm not sure how well this feature of integrating LoadPin
with verity will be by the verity maintainers in the first place, it's
probably best to limit the LoadPin specific stuff in verity to a minimum.
I experimented a bit with the securityfs option, building it doesn't seem
too much of an overhead. If loadpin.c ends up too cluttered with the
verity and securityfs stuff I could try to outsource some of it to (a)
dedicated file(s).
