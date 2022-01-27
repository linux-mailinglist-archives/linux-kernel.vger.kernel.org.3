Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815D449E8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiA0RRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiA0RRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:17:11 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A79C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:17:11 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y84so4476699iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xT5bmm2ZQXkv90xnzpvjPoRX55jk4swWNegsJQidaMk=;
        b=lmmuvr1mDR2lpp75UuTV/YmRZ/vruMXzovUf0ufPZXQSub/rdkvpFRZ6oq6ojgC6qG
         haWfw36+0F6OBHA+fg1roo1ACTNUuWBztjpenR9yAhaRSUmTKH7AcUk2HIokYLwxTrId
         AQX/P8gG+k0rBzIbyv62WVfJI2puED+0/wVaY+hyNl56xIh6Siv/I4I3cWRdcb+gODGn
         MAMMW3FWHforNa05ny6rYXkwF6CVkdEFuwhCURKMrQ63VhBdc73lgrUlJnojKPB8G3w4
         5SjB8ZCtTIP73PJ/GMbcMx4lR3Vl911uJjRmVthc540OAyjY6Ih/c0N5zqK9jdCWP7ej
         sG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xT5bmm2ZQXkv90xnzpvjPoRX55jk4swWNegsJQidaMk=;
        b=aqPUpbnrNIg61nk05/F2CT0dIN3eCbs50WsUFOBUgAUS2rM5s3DJp+N14TL1grZB2c
         lWl7KjWYq10zd5sNzuz90j4fp8t/XBZYbgqkaa1gmGlKx6gFaWD372OhwSzGItUEMFhL
         eyHQQyjgBa3bVwwd6YDPY0dcebfdH4vSEAaC61gWPuZXozI3hTqp92Sf5teOoUnyQkVE
         3Qbp6q806brZEi6ZBLQhZXR630/nacbj4g5HiakSsKmgAPKcQIc8gerpikOTbftpvnl6
         KRpHSzH/iXulae71rQzQsvcOZgf7Q+4JLCsFi/YRDfUOTIz+mv4DLwoxY/G5lL6plMPl
         LtwA==
X-Gm-Message-State: AOAM532NdXm7/IRATDkMeZSRnZqBm0H5i+d3UXa70/jHR6F5MucP9AWp
        8iETVq4BoNy+PBy2ieHIgoQjlg==
X-Google-Smtp-Source: ABdhPJwbgWzbI7aMMuKcrQvqQ4HkGfjRykM9p+OlU2Z5sQrKZs5ocBKAg3laeC7po/s7XuxJ4QTbXQ==
X-Received: by 2002:a05:6638:4193:: with SMTP id az19mr664890jab.138.1643303831002;
        Thu, 27 Jan 2022 09:17:11 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a2sm5166896ilj.35.2022.01.27.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:17:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Laibin Qiu <qiulaibin@huawei.com>,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        alex_y_xu@yahoo.ca
In-Reply-To: <20220127100047.1763746-1-qiulaibin@huawei.com>
References: <20220127100047.1763746-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next] blk-mq: Fix wrong wakeup batch configuration which will cause hang
Message-Id: <164330383030.210260.14632628670635722739.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:17:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 18:00:47 +0800, Laibin Qiu wrote:
> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be
> awakened") will recalculating wake_batch when inc or dec active_queues
> to avoid wake_batch is > hctx_max_depth. At the same time, in order to
> not affect performance as much as possible, the minimum wakeup batch is
> set to 4. But when the QD is small (such as QD=1), if inc or dec
> active_queues will increase wakeup batch, which will lead to hang.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix wrong wakeup batch configuration which will cause hang
      commit: 10825410b956dc1ed8c5fbc8bbedaffdadde7f20

Best regards,
-- 
Jens Axboe


