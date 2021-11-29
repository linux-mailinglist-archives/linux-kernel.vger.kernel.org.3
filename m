Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D2461B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbhK2Pnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhK2Pla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:41:30 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88373C09CE41
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:46:20 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w4so17361162ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=hl5Za4mpIb0SL/qd0APOvED9t8pV+X1r9kqmjSfSrgM=;
        b=eZsGBKQYA3AZlKygoTjqTCdU1O5iLaAWespWmhsDbnzyhHu/6druza6sDIQ5kuDCuD
         475lwdxY1xDvDUYxtbFP8RKlv4An1m9UizK05JW1BaSRbe87Ax66yDLEvgVDvpAn583y
         2RXLgwiUc4k7HeI8lu7P/BxINVzAiIWxmWLS0kd9W2cFLrGyihVtlRlHTsandVlUk2JM
         KyqFkjLCpJ72Onnd+HFPTm1a2qt4cVZIDv/kIzSEeWL+fwgI2ZhYZW6hFw/+NIOKxVRa
         OyC+ujResUczyUwQs7UQTnnNT+BgBuW8A5X7MNiIXfg1Tmcksp8CQ6jM26jNA3jtXQ9p
         ASfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=hl5Za4mpIb0SL/qd0APOvED9t8pV+X1r9kqmjSfSrgM=;
        b=Jw50n7CBHFzCzaWu8GUcAHHJrEApoWq7/Yki8wAJYgkBTEcTE1lDySPQ8a6eeYi+Nl
         1/59XKwVqz2OIkwY5W+/SeCFLsIFRLXo1Y2cQFEiUAwMsiorHCPt/TxR2cRCKAj5JuMS
         KF12RoJEIbGAX3O1UXQVFrgYEjD0OYnZh4vWWCXmgLdpHD58b+8ilJo/I0GfanG/5evh
         yEqb/5y5U+Vj9PyHaZDhkuZeLRPQa/PVQbsdAtT6YySRUpHXLOrC9T995alfE0R4/nXi
         8tCCfy1rgmb4A9CP1V/k92siGD44T6T2Wz5bqOifh7FyNLLq0fze2L3Qc2W3PE4wttOy
         dhJQ==
X-Gm-Message-State: AOAM533YDfueWgYw3S+2d/UggoRUEZhZN5/GaaivpkHw4yhKf76yuSSe
        ziPybRn06p3V0Xs2O6Loz5Q06g==
X-Google-Smtp-Source: ABdhPJw9V7S9eXO364y5xRo+oh9SqoIrjUyF89rVN1djB8q6Bx2jMMB7rNG3WC9CFrzn646Y0Hd8zg==
X-Received: by 2002:a92:d405:: with SMTP id q5mr543827ilm.212.1638193579842;
        Mon, 29 Nov 2021 05:46:19 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g5sm10500619ioo.18.2021.11.29.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:46:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     ming.lei@redhat.com
In-Reply-To: <20211129012659.1553733-1-yebin10@huawei.com>
References: <20211129012659.1553733-1-yebin10@huawei.com>
Subject: Re: [PATCH -next] block: Fix fsync always failed if once failed
Message-Id: <163819357457.61510.7885347054893018948.b4-ty@kernel.dk>
Date:   Mon, 29 Nov 2021 06:46:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 09:26:59 +0800, Ye Bin wrote:
> We do test with inject error fault base on v4.19, after test some time we found
> sync /dev/sda always failed.
> [root@localhost] sync /dev/sda
> sync: error syncing '/dev/sda': Input/output error
> 
> scsi log as follows:
> [19069.812296] sd 0:0:0:0: [sda] tag#64 Send: scmd 0x00000000d03a0b6b
> [19069.812302] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812533] sd 0:0:0:0: [sda] tag#64 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> [19069.812536] sd 0:0:0:0: [sda] tag#64 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> [19069.812539] sd 0:0:0:0: [sda] tag#64 scsi host busy 1 failed 0
> [19069.812542] sd 0:0:0:0: Notifying upper driver of completion (result 0)
> [19069.812546] sd 0:0:0:0: [sda] tag#64 sd_done: completed 0 of 0 bytes
> [19069.812549] sd 0:0:0:0: [sda] tag#64 0 sectors total, 0 bytes done.
> [19069.812564] print_req_error: I/O error, dev sda, sector 0
> 
> [...]

Applied, thanks!

[1/1] block: Fix fsync always failed if once failed
      commit: 8a7518931baa8ea023700987f3db31cb0a80610b

Best regards,
-- 
Jens Axboe


