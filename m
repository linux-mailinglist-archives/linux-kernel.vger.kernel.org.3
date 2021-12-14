Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B5473D83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhLNHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhLNHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:19:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:19:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q3so30776183wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VLp0o4sOHoE0u6tNwEQPnT/CZCV3x/l9Vu7pJeInEPw=;
        b=kZ4ap6VlvW1Zq9DazrqYU3lTSDwzYeabpsNz851kDLLn4b1Har38I5+LzcKEAyaixz
         dwoJA8BGDERxwO75/moXKWxVnYwY6Oqxc629PeJHMh6WjvClp++MQyKOAWYF5LOdZFas
         ARscI3zBeDtXl5AvoV2+e3M5+xxP59CxSbbBRJB1puIac1/sQL0DIl1Yy2pOiBFeswMw
         ZxlKmyUlmZLB62xdLZvfr2Znr9zRpltRSjh886ebHEn/st3t7St2aIDlcoLsQ2KY3anh
         8IxwvRXEmPsCeq0rYNNYgfO9XmB3dwibWuI2LstzbCfLegr2PS0BVoWpo9ZumWGqshCZ
         pH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VLp0o4sOHoE0u6tNwEQPnT/CZCV3x/l9Vu7pJeInEPw=;
        b=Pi/0VIo4wK02DhZ864XHQvjtZVAYJYXKmheAkVp4+DyXmtMPYSQ+WPz9tH2xZwwDIa
         jzxxm22PV2l7ydFZN5JbRzDiYOIKT0n/Q6nl9R/7LbNFlb8j8vnDhl34m0PCGoz6AkqY
         dQ0p642NR07jgElIOJoUb/WNfQGLHHWh+yuYOzfEMkZkZdcUnF5T2ver1gCBda6ngPbC
         kuYuS8xQIohz661u8DT0SoVSf2xFB0QzuE9J6mQjjCrd9HIHOXsAP76yonDdDRQ1RJr9
         O7kmSxceevOdg89c/MMAA0fN9QjhcQcQiZ0pvDrWujuTCoahYyErPRlnsBi/ZpD8WiW1
         RDEA==
X-Gm-Message-State: AOAM530cQWnjCVbH3aIyGDAUC97v547NgGMC3YsjD7dAwVfPkbxATNvy
        wOA+GdrbX+L/QeqBH+XVpKC443URtiU5pA==
X-Google-Smtp-Source: ABdhPJwvCihaLdNWdpfAn/nDjFXK1f9rMYI9jAumtJIn4e+cH920UM9sLAO6Fgd9zXEWHewsOX7vjw==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr4016335wrw.141.1639466388831;
        Mon, 13 Dec 2021 23:19:48 -0800 (PST)
Received: from [10.194.0.6] ([64.64.123.28])
        by smtp.gmail.com with ESMTPSA id w22sm1249337wmi.27.2021.12.13.23.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 23:19:48 -0800 (PST)
Subject: Re: [BUG] fs: ocfs2: possible ABBA deadlock in
 ocfs2_dio_end_io_write() and ocfs2_move_extents()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8ae1bb9c-3e58-c8b6-8823-3d2ea8b241e2@gmail.com>
 <bd6dfb63-6d3d-c8f6-f401-8bdd5334afed@linux.alibaba.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <093db193-baf8-b2c1-5667-7ded591a8437@gmail.com>
Date:   Tue, 14 Dec 2021 15:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bd6dfb63-6d3d-c8f6-f401-8bdd5334afed@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/14 15:08, Joseph Qi wrote:
> Hi,
>
> Thanks for the report. But I don't think this is a possible deadlock in
> practice. Please see my comments below.
>
> On 12/10/21 4:38 PM, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible ABBA deadlock in the ocfs2 module in Linux 5.10:
>>
>> ocfs2_dio_end_io_write()
>>    down_write(&oi->ip_alloc_sem); --> Line 2322 (Lock A)
>>    ocfs2_del_inode_from_orphan()
>>      inode_lock(orphan_dir_inode);  --> Line 2701 (Lock B)
> Just as the variable name indicates, it is orphan dir inode, which is a
> system file (something hidden inside the filesystem) and not visible for
> end user.
>
>> ocfs2_move_extents()
>>    inode_lock(inode); --> Line 916 (Lock B)
> This is called from a ioctl from user, it a normal file inode.

Okay, thanks for the explanation :)


Best wishes,
Jia-Ju Bai
