Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9353D23B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348054AbiFCTLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348827AbiFCTLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:11:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F762280
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:11:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x5so6282686edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIclXdDuwkuHFRF1yGwl+vB5wE/sELhI0XxIv8Oxd5U=;
        b=Uah1rtndf2sVwhb8DZfowbNVE3U5P1CmFUvrcf7fR9U/u69ua6fBafj7xD8H8sP7qX
         NjyJhOUAf3w1jzioceyGRyOl4ve6BfQdgq73df2ZQjHFrbLTpD0PeWoR/949yHHnRWKs
         D+r1IGycNIBpwfHdFpR4lMXZyGhLfL+UmAh6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIclXdDuwkuHFRF1yGwl+vB5wE/sELhI0XxIv8Oxd5U=;
        b=op8vaCRqLgTiv9KZP7rsHIEqUWa0gG/cezyUa1KJCU5F9MTDB7jgIr+DqRjKa2glKQ
         hvM46ph3idgwm9XR21ta/r6Mh8KdeJI90dyGS16goeVmKFzzPoye6otNNfTTBav92Yfw
         Rj24pXfwsGDhOMQhSRSGgn9fx0fAVqkBK6c3wbIW27C/PXDsLAp7Dp/EOGWSIGYSA/Pu
         8M0Z5gDFe5XPR/qtO/szP5CHn7XebIFN75vDeuinxDS3S4AP2BhwLKRfzeX0pobIklM+
         zIvIMJvDw/Sqvf/jI0ILp4FEIpqfvpe9w2hz9r9Ywj1E8ceTs7qm7hLWn7M6+LCljRuR
         3XpA==
X-Gm-Message-State: AOAM531SaqbS5HJ266vMR9OxtPUJffsNDQhuFsMyy6lXI4NHpYAVrNSd
        lYsI9DKypGh/W3F3+QA3Z9N9dP+PwunO1qMWp/8=
X-Google-Smtp-Source: ABdhPJzpbsRREA60E5r8m2ffk3ipwYees5UGcvT3QBNU03WbGyuVuwODtoY7UiaSUe1BjAunqOsBBA==
X-Received: by 2002:a05:6402:1d4a:b0:42e:9ec8:320b with SMTP id dz10-20020a0564021d4a00b0042e9ec8320bmr4164434edb.119.1654283507574;
        Fri, 03 Jun 2022 12:11:47 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906645700b006fe8a4ec62fsm3159203ejn.4.2022.06.03.12.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 12:11:47 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a15so3020026wrh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:11:46 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr4018506wrq.97.1654283505845; Fri, 03
 Jun 2022 12:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
In-Reply-To: <YpnwZ/Q5yTKRDBOD@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 12:11:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUHjXWUCyyS9Q5TFS8Wc=qJk2q2-sLFVVtqgUi4vfnrQ@mail.gmail.com>
Message-ID: <CAHk-=wgUHjXWUCyyS9Q5TFS8Wc=qJk2q2-sLFVVtqgUi4vfnrQ@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 5.19-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 4:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> It's that last change that I'm the most worried about.  It has been
> reported to cause boot problems for a number of systems, and I have a
> tested patch series that resolves this issue.

Ok, pulled and the two patches applied on top.

               Linus
