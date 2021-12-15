Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECB4761CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhLOTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhLOTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:34:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:34:38 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id w1so20199285ilh.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYuJKqVn7Dufbjabi8CjodjpBv4ACD8m6+dlUH/6df8=;
        b=IgEyIy/9MvGru6oGIjcd47E6pH+tmCMPgWAu5g5fJRDmGYzHMaSl/xq1X68lOzMJEb
         Ogmz9ta4k4LQuh+tlxxy1S/QiPpgo/7uf1Seo/KHZXT6lAO+EnxwLHzeqMWQeU1L/rVb
         p7W+lls6HNy6IiRWI+nEEwsaSaFkgvkQ2u1seErcsWL2FNQK9glG/LVupOaRkcu/3nqd
         THCNHiGUaf6ozXEha6yYDgfsgVvJMd1DkxfD1kvlfmPkTtQsDDIJmU2DkYdLLF6b01nv
         51wSJdDY2JShyRmeLVmCkYHn3w50x7ip672QQlxsr4fe0WeeK/iu+KKRIDFiTZBXwmPa
         fCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYuJKqVn7Dufbjabi8CjodjpBv4ACD8m6+dlUH/6df8=;
        b=2DbzCqL1eL4LmiPtZLg7nnV6ay2epxYE8087ihnNvPriSast2ZTWtUBCWs8E1zF/cv
         Mx14hZj4Tk9mmLc6gyMKZEiS7im+glFHTIO/fPUT5LAreW/03ufFHqFmt2a8xEB0n9nw
         8UeFXaqFCq6GaXM32CImBKyO/dFhLrqPtsNF1RXkx1HNd/YZPcIHyIz7YFKNiX9YPxxg
         er1GITtNFCheRnU4ZrzsRvkHzXxd+WSXBiM9OWb2vLyvdMgnVXT0FEN70LI2obLeBFqy
         atYWJE8/3ylfR9KbTNJa0LTNYWHHURdce9jucY4qVp9c0wGXsZLXhXlQGdkuIcJw1Xeg
         Lf0A==
X-Gm-Message-State: AOAM531tnGnKIpSouPF59OKfypgQesDJWYZ47cLdqopdm8JzZQJXoF1u
        LPoNJt6BQvD+xXlkuroIDzv/pw==
X-Google-Smtp-Source: ABdhPJyCwB+0QpTfDuFl0wmjchcOgWrh4jG6Rn07fk+46K379Kte18I++eGxTuUOw/EgEfDTAhCcmA==
X-Received: by 2002:a05:6e02:b4a:: with SMTP id f10mr7275230ilu.281.1639596877741;
        Wed, 15 Dec 2021 11:34:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q132sm1462857iod.18.2021.12.15.11.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 11:34:37 -0800 (PST)
Subject: Re: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw spinlock
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
References: <20211213123737.9147-1-wander@redhat.com>
 <20211213123737.9147-3-wander@redhat.com> <YbohEio+66fyFo6D@linutronix.de>
 <20211215123116.622da7ef@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f3300ba-0879-ad7d-8d44-bb8d8b17d7e2@kernel.dk>
Date:   Wed, 15 Dec 2021 12:34:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211215123116.622da7ef@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 10:31 AM, Steven Rostedt wrote:
> On Wed, 15 Dec 2021 18:08:34 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
>> On 2021-12-13 09:37:37 [-0300], Wander Lairson Costa wrote:
>> …
>>> To avoid this bug, we switch the trace lock to a raw spinlock.  
>>
>> Steven, do you think this is a good idea?
>>
> 
> blktrace is actually maintained by Jens.

Looks like there are two patches, and none were CC'ed linux-block.
Please resend.

-- 
Jens Axboe

