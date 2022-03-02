Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9094C9ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiCBB7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiCBB7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:59:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C51E3CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:58:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so450987pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=040H+jP+53pEVe8pSDUK+vIZ701zB6vSQGunm0nf6A4=;
        b=BeKCYy+Cp04neWYuaSPBNRqQVv54iyitFFWwHoz61+nudk77cLiW3SqCq0BV+eiRFp
         bdBigSvwiRjnSBwncXoKVSqfL185FtcIDo5kLoyIKV6LScVg5gi4sFLZaKInWihVnhs9
         9rZ9gp9hSTImzfyILbGy7at6ScCz7HVqEdlzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=040H+jP+53pEVe8pSDUK+vIZ701zB6vSQGunm0nf6A4=;
        b=0HSxb9PasnUupfifP0ZQ+mklfFN6ugIUB4HZ8RWFgb126UFJgUZ8T9NfqnFFi9MNO9
         +UHgdHvCop4MY0/meLu+jY7NOGNtTj4C5Ku2yP2Q9M/FaKACQ/76fKUYGDO8yC+UNiY+
         n1JMytiudVqkMvJv/w9WIEfB7iwanZ6bOlGPtmmFoDOpuizXQDoIQIk9xfVsokDTuIr0
         WnBVyPgZnCKTNslyA9jP4SfWXE3RDMXXMKHhv5nTdTKg+Rd6n9k8GL1qmCCyL77T5zSZ
         vQ3bq7CFJWOYfFwjWE81dBMcrsFgwQystPwF2u2Mffo0bDFwl+lK3h/b0F4KBT/nejRq
         KnOg==
X-Gm-Message-State: AOAM5319HE1y6Qvru1l1tdFUB6pYQmrTjC2V+ZHmkR6STLjyXB4NfUFJ
        G4OOFkv1W8DrVmL8zvW1HBqGPJ3viIKA4A==
X-Google-Smtp-Source: ABdhPJxK0JiZgCgWV6b/lEhDkqi6lJzOLVrQ08TH7Zz4bAW2WnZhEpXtngB4U9+SWscGTnzBSQyIIA==
X-Received: by 2002:a17:90a:7d0b:b0:1bd:6d57:dbcb with SMTP id g11-20020a17090a7d0b00b001bd6d57dbcbmr9162639pjl.2.1646186302490;
        Tue, 01 Mar 2022 17:58:22 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:58fe:72a2:6388:dcd2])
        by smtp.gmail.com with ESMTPSA id g4-20020a625204000000b004f1063e3d6csm17639434pfb.125.2022.03.01.17.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 17:58:21 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:58:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: fix return value of printk.devkmsg __setup
 handler
Message-ID: <Yh7POYBnSVeXuI5o@google.com>
References: <20220228220556.23484-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228220556.23484-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/28 14:05), Randy Dunlap wrote:
> If an invalid option value is used with "printk.devkmsg=<value>",
> it is silently ignored.
> If a valid option value is used, it is honored but the wrong return
> value (0) is used, indicating that the command line option had an
> error and was not handled. This string is not added to init's
> environment strings due to init/main.c::unknown_bootoption()
> checking for a '.' in the boot option string and then considering
> that string to be an "Unused module parameter".
> 
> Print a warning message if a bad option string is used.
> Always return 1 from the __setup handler to indicate that the command
> line option has been handled.
> 
> Fixes: 750afe7babd1 ("printk: add kernel parameter to control writes to /dev/kmsg")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
