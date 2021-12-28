Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C74806F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhL1HSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhL1HSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:18:13 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:18:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v25so15314494pge.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=gA0ge5qDn9G6uzsgw9S7cd95iGIT0BOtbhzvX/7hD5Y=;
        b=ewHhWd4IHNFG9Orz/2kY6QzgTeTJ84zVFFAQKHoEWHbiUxmMlYWHxAttxEz+KO2+c8
         6wRPkGDBfgxC9EALFu68LyBpNf7HT9vnWgBsGwnTj0J0k5+YlhMpax4AeDvvMF/cEd2x
         IHsRqJNBcZoJ0c1OQPLlu+WkmRczwNG6rpt/EtA/WbpsHAtolkFYawgstLzlveTIpgQD
         vw8nNIQZ4DWf7WuwG9OoyqYdb+sTJSTn8XHfpIm2MetLnMJfp9Z9uJoD4lKGpzooIEBW
         MrGlxGyFVoNZbrhviiRG/p0QxmlmApmspv4Puwq1OXHVPcx+Nd3sy0w4DsagXjJBm588
         mUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=gA0ge5qDn9G6uzsgw9S7cd95iGIT0BOtbhzvX/7hD5Y=;
        b=VSHftOzv/tlvD9toXpY8vmRHV33NLGR8PlPq9icejAN1FXIYDE+jVy4gKWOfOOu0ZW
         hSrAWkTO2018qnY2eYjWJRfyo9QFTLI8UEXQKT0+YkWnxmL1dArsvCathKZJYRBYiVAf
         DBR6z6+m7LMstEEXty1exo2c7U+aqZ1kQbRMZmS0ANOkVG2+148fhjQLwB7r5MjAANJz
         68GeyVP18n83d+VIYfXbCNG/DcY5u7NOv+K2m+zjmShSHJLNg/K90lxTPyivhX53UUyx
         ctYLlongKgi6wQHAGrAnkybs6xnvOJPw8axgBn23wAEzEWKB3X+BuDt9YybJ/9wPzaL+
         B2pg==
X-Gm-Message-State: AOAM531RXH+lKedrb87crtAKUgHl//aqkJGLk9QxGq3AgvQiHJ9iZKn2
        9hiut1L3Qb8DkiyaNDu2QkZ74UEsMTU=
X-Google-Smtp-Source: ABdhPJwiNLAKBrgJMVcRQJZ8sbDIPpyhHQwkmVHGO4EIRUTzURMKOwaqYy1I70udhw5cnBmSGMB69w==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr9137103pgc.503.1640675892757;
        Mon, 27 Dec 2021 23:18:12 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.127])
        by smtp.gmail.com with ESMTPSA id lc3sm21634075pjb.2.2021.12.27.23.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 23:18:12 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org, zhansayabagdaulet@gmail.com,
        christophe.jaillet@wanadoo.fr, insafonov@gmail.com,
        paskripkin@gmail.com, deborahbrouwer3563@gmail.com
Cc:     linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] staging: rtl8712: possible ABBA deadlocks
Message-ID: <8d695b41-74e6-4733-4841-e21fdebde890@gmail.com>
Date:   Tue, 28 Dec 2021 15:18:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports several possible ABBA deadlocks in the 
rtl8712 driver in Linux 5.10:

# BUG1:
r8712_free_all_stainfo()
   spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL); --> Line 202 (Lock A)
   r8712_free_stainfo()
     r8712_free_xmitframe_queue()
       spin_lock_irqsave(&(pframequeue->lock), irqL); --> Line 834 (Lock B)

r8711_wx_set_wap()
   spin_lock_irqsave(&queue->lock, irqL); --> Line 1049 (Lock B)
   r8712_set_802_11_infrastructure_mode()
     r8712_free_assoc_resources()
       r8712_get_stainfo()
         spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL); --> Line 228 
(Lock A)

When r8712_free_all_stainfo() and r8711_wx_set_wap() are concurrently 
executed, the deadlocks can occur.

# BUG2:
r8712_joinbss_event_callback()
   spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2); --> Line 735 (Lock A)
   r8712_free_stainfo()
     r8712_free_xmitframe_queue()
       spin_lock_irqsave(&(pframequeue->lock), irqL); --> Line 834 (Lock B)

r8711_wx_set_wap()
   spin_lock_irqsave(&queue->lock, irqL); --> Line 1049 (Lock B)
   r8712_set_802_11_infrastructure_mode()
     r8712_free_assoc_resources()
       r8712_get_stainfo()
         spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL); --> Line 228 
(Lock A)

When r8712_joinbss_event_callback() and r8711_wx_set_wap() are 
concurrently executed, the deadlocks can occur.

# BUG3:
r8712_stadel_event_callback()
   spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL); --> Line 932 (Lock A)
   r8712_free_stainfo()
     r8712_free_xmitframe_queue()
       spin_lock_irqsave(&(pframequeue->lock), irqL); --> Line 834 (Lock B)

r8711_wx_set_wap()
   spin_lock_irqsave(&queue->lock, irqL); --> Line 1049 (Lock B)
   r8712_set_802_11_infrastructure_mode()
     r8712_free_assoc_resources()
       r8712_get_stainfo()
         spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL); --> Line 228 
(Lock A)

When r8712_stadel_event_callback() and r8711_wx_set_wap() are 
concurrently executed, the deadlocks can occur.


I am not quite sure whether these possible deadlocks are real and how to 
fix them if them are real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
