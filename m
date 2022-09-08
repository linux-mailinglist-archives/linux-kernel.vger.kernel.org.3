Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31C5B20EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiIHOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiIHOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:42:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B88112135
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:41:57 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d68so14199865iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=eWi2LVN2gecP1iaDEZcOslHil4OGn6GfTQ/ywsJxRU4=;
        b=LKjkr2bv+FmCGfu/Wp+AD7fL5K2pMWUUr/vV1s25dbXJVUx4TqzGAbIbs3U+FdZr63
         EEMPNe4U/xW3wZjBLydVXb7nPwUitbFOhP21p+51luHDGlI3dTd3IkqtXQ/9ozFWmrpP
         3eCBO5dLwo0G5exrT/POHuU9YMjrmwsl9x5eaFnxTXtPsUqKdwVw7KV+suaLHEEqTaGn
         C0PCYewzgTcTwu/EhdpJ8446cqW/bEsR6CtOhbhVo10yxauhr6xdI5ifbeq4Hib/e8Wx
         UnRE75fukNUY+jS9IzTAvhetyrmOM/lsaZaa7sCrin/ytRc5yrFpcpFr/l5SsNBShxtC
         RDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eWi2LVN2gecP1iaDEZcOslHil4OGn6GfTQ/ywsJxRU4=;
        b=H48FE2zn2hSCR900TFLL8XOuxI9E47x91pDLokyGv+yWZdT86mTCGMXQACptzZvIBB
         0XuoA6EWaImSKxjXuCwMnAjvbR4GKFUZwPsHR3WtdLKIss2gPwQ5iTTbUwsZzSNwkh7F
         tp+jAb2spiYSMsJ6m3wrLFH+oMHA+oW2i94cAbI3f6YKoHgEIi2Jdz+NrnTVVXM/NpDi
         e0k7S8t2+MGx1srUIkfxKlKav10oXw2IePw/TM6P1PRUYNrvtfl1toCd8YxQvaf14I+A
         aUgQWE3gYD80ayGtZ0gTVdJWAAwAAQ2vpYFV38xnrbQFBokhWQ223Kyk0FbxPyqNL4In
         DOaw==
X-Gm-Message-State: ACgBeo3XPByvTguTeb2VrH3nctPm+S4cgPA2j1QGJMU9+IYIgnSRkDzP
        N8qZZJOC97FzmK7lulxCnpfEkZvsD+ADVQ==
X-Google-Smtp-Source: AA6agR7lYfm0H3nIDGjlRvtjZ9XMOgf94oL/eqyyJX1dmi3uEefT+PfOmLB45yRQs15z5OC/ZSTMmA==
X-Received: by 2002:a05:6638:2103:b0:346:c965:b935 with SMTP id n3-20020a056638210300b00346c965b935mr4811111jaj.205.1662648115499;
        Thu, 08 Sep 2022 07:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k131-20020a6bba89000000b00689abadc36asm1146694iof.3.2022.09.08.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:41:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
In-Reply-To: <20220907163502.577561-1-syoshida@redhat.com>
References: <20220907163502.577561-1-syoshida@redhat.com>
Subject: Re: [PATCH] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
Message-Id: <166264811452.472176.16885663961423246810.b4-ty@kernel.dk>
Date:   Thu, 08 Sep 2022 08:41:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 01:35:02 +0900, Shigeru Yoshida wrote:
> syzbot reported hung task [1].  The following program is a simplified
> version of the reproducer:
> 
> int main(void)
> {
> 	int sv[2], fd;
> 
> [...]

Applied, thanks!

[1/1] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
      commit: 1de7c3cf48fc41cd95adb12bd1ea9033a917798a

Best regards,
-- 
Jens Axboe


