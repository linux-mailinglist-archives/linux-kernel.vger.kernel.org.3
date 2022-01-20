Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5D494F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiATNa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiATNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:30:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80430C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:30:26 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a18so4970459ilq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5UnmskyHNG5ZrnVj7B952INTBTaxqow5mDngjiluqss=;
        b=z82sHatixwbGF6nSRmKEK2yFpA3IAXaEwW/S+J6o6sDDjca1Fy8/KPAozNr6sfXTjO
         OuAGFHna1qYnbM776n2NdROosJkwAezHPf+sMhNsMj0qXJtWZX1Azlz8C8W54/7RZrhv
         ntgw0+ge0d6qPCV/o1QfUl8APjIaU0BhWWu0e2D3FqF6kaPmL9goVH5d6d3d/1WzAvdx
         Na1EIPxHL6aIBpZrJ7FZc2ke7LGsCNVl/CN47M4d9cs7Hy/756jn2ZHYTzn3HmUxM9hJ
         EA792IXMuixzPX9teGd6+gFxa+d0kyYCwsIXAnCzVo5hxVNvWIEouYNQr3z+ln+6jfyp
         m1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5UnmskyHNG5ZrnVj7B952INTBTaxqow5mDngjiluqss=;
        b=srLRhPH/TBQMQIXtmvMfPIwziId1dmftRxBFG2W5emVs3l5/0hY8XbV8Mey5Kif4fz
         Du3v5VHEqvTztYStTwOSt+L7X5GIFInfJeyzvIBdFl5dnBCF5xrpU4e1TzXDhabMb6/X
         qGHBjEvuPOBJmyeTA7Hh2M6ZyclKaBiUxZkIfgObG4K57rDCUBDBFx6BztbxUI7Z7Gt6
         7sCrnHG79/+tOM+gDq0THzE3vA2+A/G47yyTtO+LzOpKj0sBosUB8Lh7ndUcKJgQi49E
         2uiEY/zuCy1Z6xDkbxT3G8DuWylly6JSFMrMxwJl7hTr138oxABShpWAe69Gd3AeeM+Q
         xArg==
X-Gm-Message-State: AOAM530kfs6fH979EhEUnD+Z1ZABFTiG0jJeMW9Nx10kQlzEme8PXI6N
        tWOjtKxtnpp6wonA6y1aX3Y+n3nPS2ykPw==
X-Google-Smtp-Source: ABdhPJwFZ5b64m2rn9m2glx8SvcTfImp5FdrnmiMhpWyVAVDt6YAodHnVu67dd/cOaF/8TP0QvZyrA==
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr19686799ilu.191.1642685425422;
        Thu, 20 Jan 2022 05:30:25 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d23sm1443754iod.26.2022.01.20.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 05:30:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-block@vger.kernel.org
Cc:     syzbot <syzbot+ac94ae5f68b84197f41c@syzkaller.appspotmail.com>,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <875yqt1c9g.fsf@mail.parknet.co.jp>
References: <000000000000880fca05d4fc73b0@google.com> <875yqt1c9g.fsf@mail.parknet.co.jp>
Subject: Re: [PATCH] block: Fix wrong offset in bio_truncate()
Message-Id: <164268542304.61815.9970184633084359443.b4-ty@kernel.dk>
Date:   Thu, 20 Jan 2022 06:30:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 18:36:43 +0900, OGAWA Hirofumi wrote:
> bio_truncate() clears the buffer outside of last block of bdev, however
> current bio_truncate() is using the wrong offset of page. So it can
> return the uninitialized data.
> 
> This happened when both of truncated/corrupted FS and userspace (via
> bdev) are trying to read the last of bdev.
> 
> [...]

Applied, thanks!

[1/1] block: Fix wrong offset in bio_truncate()
      commit: 3ee859e384d453d6ac68bfd5971f630d9fa46ad3

Best regards,
-- 
Jens Axboe


