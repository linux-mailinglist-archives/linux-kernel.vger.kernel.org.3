Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6D5B0B76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIGR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIGR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:27:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA182D3F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:27:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h27so11006643qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sOJSFaykwA71BM98SyYsFLb6fIMi8ySU+zYqTYP9bc4=;
        b=lN8CxxKRIuPWjEOgSoZDvX6twhOYfL3Ethh3d6ax4lwlse73go5Cw5kUAxPRZ5EHc6
         o5+7VylM43zMPXYIkijSH5ew6ssQ/yLKhWFU8fl/WwkW/RiCtsI69TJznTs5U4aCV78L
         InhhnnupX/mZOKVEcsBBFXLxfy/BNtXcMr+cvM3j2+MrxY6WsvWnrlOJbTpkjTIzutt7
         VhVQj4sLhWbs4Z/7haL7TyhFBLilcPMku892+BkzblD4hbgt47OTujp7oMSIhF2XCGhk
         zTzddwz/KbRAHpOaiA0f3Vo2w8LoiAkXKUCIQ9ZmzYx4CsMUdnuylkcVaxQSnUswzv6m
         r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sOJSFaykwA71BM98SyYsFLb6fIMi8ySU+zYqTYP9bc4=;
        b=aDFTdQ2+bQF5ZK1FCjao2GNZMTD1L2hT0lYePKbf7PJsMzDxpUtsRCVm3kOoDZQ44x
         exfAHuJdAuXFKflmvYcxYMAdN5THjrV5ENEDspr/cUOlIT9AMFPd+K0PB1dHliUIUgbZ
         0BdzFRgbdqBytTiE/td9Qf9R+iJv6lKWTO1tCdsxrl7s56RG1sAdC6R5nkKYrtDEKQXI
         6EshAZMLR2dAbV0Wyu/lRy71bRj9VZS/JLbuaIK5kd6q2wPlGoFoA4M8MBt4tefkHAdc
         B8t2Q/Ncv4z029mzSDB82Z7KYBaLvwnNvpaym9r7wM8k+k5Vtu9NMQV31utNPs/LAvAd
         IyTg==
X-Gm-Message-State: ACgBeo1RoeK0tr7oc3pMsKRopkbXZ8adj9oPK4qOFSq3Ki+OVKXYtdIe
        WFXULldxIl1lknFWWGfKmNNyYQ==
X-Google-Smtp-Source: AA6agR4+oBzuazP2mneC5bji7XTtzimB5QvY91JcE6Zp0ly/g79PWWAzf5vSEBI6QH793GlX1IP5Gg==
X-Received: by 2002:ae9:e519:0:b0:6bc:475:abd4 with SMTP id w25-20020ae9e519000000b006bc0475abd4mr3475473qkf.310.1662571652857;
        Wed, 07 Sep 2022 10:27:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id gb3-20020a05622a598300b00359961365f1sm1647235qtb.68.2022.09.07.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:27:32 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:27:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: Fix hung when signal interrupts
 nbd_start_device_ioctl()
Message-ID: <YxjUfQUc66B+N1e7@localhost.localdomain>
References: <20220907163502.577561-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907163502.577561-1-syoshida@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:35:02AM +0900, Shigeru Yoshida wrote:
> syzbot reported hung task [1].  The following program is a simplified
> version of the reproducer:
> 
> int main(void)
> {
> 	int sv[2], fd;
> 
> 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
> 		return 1;
> 	if ((fd = open("/dev/nbd0", 0)) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_SET_SIZE_BLOCKS, 0x81) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_SET_SOCK, sv[0]) < 0)
> 		return 1;
> 	if (ioctl(fd, NBD_DO_IT) < 0)
> 		return 1;
> 	return 0;
> }
> 
> When signal interrupt nbd_start_device_ioctl() waiting the condition
> atomic_read(&config->recv_threads) == 0, the task can hung because it
> waits the completion of the inflight IOs.
> 
> This patch fixes the issue by clearing queue, not just shutdown, when
> signal interrupt nbd_start_device_ioctl().
> 
> Link: https://syzkaller.appspot.com/bug?id=7d89a3ffacd2b83fdd39549bc4d8e0a89ef21239 [1]
> Reported-by: syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
