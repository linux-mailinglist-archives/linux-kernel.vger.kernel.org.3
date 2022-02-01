Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E244A5783
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiBAHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiBAHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:09:44 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A8C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:09:44 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 132so3508226pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=30OxmrfKBbCG4hj/X3lsJFFvPMa8rJcIl2RH+GTl1+c=;
        b=mhDV0XtJlte0Om1SvFzaHSKspJpOm4zs+iaK7pwkTbq02CRjXk7keFp0VG1dgt3NAQ
         HhZlEK8n/5JsdmEiiQgaYAyhBJ8QJOSOQknTuBXjZ5oj0+MtTPh8fVsqxVLFjWWxuW/v
         wQ59egONKIocS0nvyFlCnlLGT1yIaPO14HhFbVcCyQVsX0TqGvo+HUCSJcXUOnI2pC10
         WNBa763RKmq7xot14B/U2BzflA796QfH98wCFvmBVEmtiQ7VnCtqIvoblsjaW236AAgf
         shU7DLKubnotSnFp/70OkQBgfj8DGsLOwm5y2os0E/SHhZpxFpX6lMq6hMmvbIRKOdOD
         TMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=30OxmrfKBbCG4hj/X3lsJFFvPMa8rJcIl2RH+GTl1+c=;
        b=N17oqmJdJTJ7trhr9Iy89kyJGNdS+GqTjw+sxYd8cZnL0/RywwDu2ZmpwFBW46Wlul
         aKJzWF03Q3wRXwxPy1aT4PbeW9Tt7bfC8muhlNAA+dM5QTdBy2QThe05UuOgZ/8eo6q2
         RXYmBMidUHzYx/LB5OCw4aDEXqAOkDBEobOCjg6EcHvYDDYy8G06TiY/EspvCBsnyhS+
         63exZNg4xQVtUAMj/iFQtsd7/eAAln7do61YYqQJd4aQdsdETeSYQrYQCKDkwsEbg6lh
         9YdrHe0DP/BhwImIGpPnZgT60S5zFxfXEzRryIn0+CAcRgSzGiBmnDBq9N7a4blsukP4
         b/1Q==
X-Gm-Message-State: AOAM53049Uj1htpNJp8wBjZEhxwVPxa05DeTUQOD0wzaB5yAwxovNq8h
        xUCaFklWyEBeZjTnyaVk/Zwz7VfyQA0=
X-Google-Smtp-Source: ABdhPJziuKz49mS+l3/gxjF2ulHnmtnYWYPEnlwQpCgJgPtp9ORDVwZExaGCW2JC7ubPOPU27LhpOQ==
X-Received: by 2002:a63:f30e:: with SMTP id l14mr19357924pgh.410.1643699383259;
        Mon, 31 Jan 2022 23:09:43 -0800 (PST)
Received: from [10.59.0.6] ([85.203.23.80])
        by smtp.gmail.com with ESMTPSA id q19sm19964158pfn.159.2022.01.31.23.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 23:09:42 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] staging: wfx: possible deadlock in wfx_conf_tx() and
 wfx_add_interface()
To:     jerome.pouiller@silabs.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <6f489bf2-bac0-8030-7ea5-6f5c12daa568@gmail.com>
Date:   Tue, 1 Feb 2022 15:09:34 +0800
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

My static analysis tool reports a possible deadlock in the wfx driver in 
Linux 5.16:

wfx_conf_tx()
   mutex_lock(&wdev->conf_mutex); --> Line 225 (Lock A)
   wfx_update_pm()
     wait_for_completion_timeout(&wvif->set_pm_mode_complete, ...); --> 
Line 3019 (Wait X)

wfx_add_interface()
   mutex_lock(&wdev->conf_mutex); --> Line 737 (Lock A)
   complete(&wvif->set_pm_mode_complete); --> Line 758 (Wake X)

When wfx_conf_tx() is executed, "Wait X" is performed by holding "Lock 
A". If wfx_add_interface() is executed at this time, "Wake X" cannot be 
performed to wake up "Wait X" in wfx_conf_tx(), because "Lock A" has 
been already hold by wfx_conf_tx(), causing a possible deadlock.
I find that "Wait X" is performed with a timeout, to relieve the 
possible deadlock; but I think this timeout can cause inefficient execution.

I am not quite sure whether this possible problem is real and how to fix 
it if it is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai

