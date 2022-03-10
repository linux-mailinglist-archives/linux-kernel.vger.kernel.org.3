Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2AA4D41DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiCJHf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCJHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:35:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB579C78
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:34:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a5so4423686pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/cRXQiSJ5rIWf1RgUsbCqPw2RjGrtPdegUrxegBFwDg=;
        b=drrvyjXC5GTw4mGN3hjmCpR4QqGXIdZSM8NzuvaH9FuH+GTzewAH4wwF4CgXUGxcdJ
         5TnxSaZKkOGH5yGtGUUzB37aeaMs9mvj0uLtZ2ganFOtQa86at1qEmdYMYvzfUDN/GIO
         O4rhe3+a/Z7sFLYsq+h9w3AKpTJ9SpNVv3H1Aw1kwhHo+JG4+LuTXBUBYY0rqWQghPpQ
         bWHTyxzC+O9Np97hHOAC1dk329FWk4V4ijry9Wgxj/8gGRCP8o0laEBybE37BQO+j3Cy
         vajQqKyd7NcfoUaPMrXhgQqD8m5o7M6z4UNC3YyZb4gb4MgpoUSVbZn41VMgICH7+oeN
         rNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/cRXQiSJ5rIWf1RgUsbCqPw2RjGrtPdegUrxegBFwDg=;
        b=Uxy5Jhsz2YsFkHF+PmGnapyRw0Pn2PjZV+YbzSgpM6/aP7FcHgDTuA5XWkKLDZewLY
         r297fH29P9gqTI4hjaWJeM6iGdxH91BrVoAEkhqeK9+fuq/NVou0DPyTj4YQH6NF1+P2
         ubbocuoItza0Gsdfb/jlBEQ9l9QMq+NIaOzLfjBCGEJ8IOer27W86A3V22QSuj9BA7IY
         6uHyJPisA860RR3NrT+adpCz/SbLOvW9VohwpOOEzTJSYlbSPJoWKHVy3ie/qIzKfRgU
         QeChcztVQHnk3cRbvvj1+NwK1HCP+sTU9Te4RXPRgLfByj5FXISJjj8W/LXl8yK1mPzZ
         0bqw==
X-Gm-Message-State: AOAM532o2xZ/kbSxELuUpieoKqgUpL3t31rSa6ghYtnFfWuD6/Lm9NRL
        eY3GV/Sl/c7smF1IXodkt6EHSQ==
X-Google-Smtp-Source: ABdhPJxc+q7DDbxs0t4/P+31ptJrnup2lYJR0GZZf7c/akfYD1VQ0loaR35m7vzsGzW58v1D87rQwQ==
X-Received: by 2002:a05:6a00:2444:b0:4f7:73bb:7582 with SMTP id d4-20020a056a00244400b004f773bb7582mr2011116pfj.39.1646897666298;
        Wed, 09 Mar 2022 23:34:26 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm4482675pgk.74.2022.03.09.23.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:34:25 -0800 (PST)
Date:   Wed, 09 Mar 2022 23:34:25 -0800 (PST)
X-Google-Original-Date: Wed, 09 Mar 2022 23:21:11 PST (-0800)
Subject:     Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
In-Reply-To: <YimjbmdACoQOk+hj@infradead.org>
CC:     michael@michaelkloos.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-08a28047-b563-41f4-b705-f27b88554f2c@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022 23:06:22 PST (-0800), Christoph Hellwig wrote:
> Why?

I have no idea, but this has come up a few times before.

IIRC the original port had a no-M flavor (don't remember if it even made 
it to the original patch submission, but it was around for a bit).  We 
decided to drop this under the theory that nobody would use it: 
essentially, if you can afford the handful of MiB of memory required to 
run Linux then you've probably got a multiplier.

If someone has hardware that lacks M and users care about running Linux 
on that then I'm happy to support it.  I'll still point out the 
silliness of that decision, but if it's too late to change things then 
I'd rather support the hardware.  If it's one of these "fill out every 
possible allowed ISA flavor, even if nobody has one that runs Linux" 
then I don't see a reason to bother -- there's an infinite amount of 
allowable RISC-V implementations, we'll all go crazy chasing them 
around.

FWIW: to a first order, that applies to the no-A stuff as well (though 
that got dropped because the Arm folks pointed out a way to support that 
was way better than ours).
