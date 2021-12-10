Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654CA46FCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhLJIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhLJIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:41:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0251C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:37:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id np3so6316141pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 00:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=/skXCn/Kvartrp3IdwTGEm49Q3dI9xZw4j/EZZZx3aw=;
        b=WLcF2GpIxtzX7yUdlOL97Y2QNllL0l89c9tA4QGonQKq2tsudGBGotBdtcaFwxQDfy
         thnVq0N4Q1NbGk3wWMTX+uU4IS3pOI/dsyWXMfyqADmXGkTGSAL6uT24d7Fyn15N2tc8
         kwS4guU2J+npUwjWNuU6to9kuKHz2KGFMwfvLGwEs01UMpA/A/uikPTqh0qEUiageJvK
         Ok0zocA1RB/csMuqqp+zVo/V6f8DZ9tB9oVPEXwQf8xLsOeMjxBpc5X6oR29eiQxIVML
         LNFfVt+Bmr0G1534q8DD5yUHMrloq/EUBwCFX8tX36eoDql/i+7qHsN/r/W/+3pA10Da
         7ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=/skXCn/Kvartrp3IdwTGEm49Q3dI9xZw4j/EZZZx3aw=;
        b=K2ylUE/pc6dFHE7ksa1lKn35oGtzKJLIolOcmS1BLmPa56ANUcC25kIGYWapkzIHIa
         eCx3xDo6CW7JB2fn7LCk30faMz+B1rwVIuDqD8vHfqJP1v+wnnosuLC0Y3ObtufY25JH
         5e1e8QHSIy1cPu6Rscxm7pUnjLWxEH5+a38uiKgVfaaSB1DoO66vQkvnOBWbAyyiIXg/
         IsTjHojKbB4KRPBnJpD18109FnMjm7WICQUHNupAJyd78+c08g8Wvu0Hn448CRZmS/5e
         F+3oIUzXwQ8EoMhIOukCfCtjm1xQzRqOV2wYT+pCuM3/I406VR81Jx7yA+d4f2Wh1Eq5
         xHIA==
X-Gm-Message-State: AOAM5339w0A5lOJhXzaeN5Gi9ViR8De05MbkIZvTwKv/sZsEE4fEM9Zp
        bG6KyM/uTt7bS8VFlgdOgqIm36knNQ8=
X-Google-Smtp-Source: ABdhPJxHAfB/HSphl4IqTE5nrV4OrIGHVWTYX9cHIK60HeXqAbJ7iVfDYQZR0p55vJMxFgk85KDprw==
X-Received: by 2002:a17:90a:3045:: with SMTP id q5mr22126989pjl.58.1639125458121;
        Fri, 10 Dec 2021 00:37:38 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id w6sm2417709pfu.172.2021.12.10.00.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 00:37:37 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: ocfs2: possible ABBA deadlock in ocfs2_dio_end_io_write()
 and ocfs2_move_extents()
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <7713e8e4-d397-ab73-4277-c03cc7d1c227@gmail.com>
Date:   Fri, 10 Dec 2021 16:37:31 +0800
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

My static analysis tool reports a possible ABBA deadlock in the ocfs2 
module in Linux 5.10:

ocfs2_dio_end_io_write()
   down_write(&oi->ip_alloc_sem); --> Line 2322 (Lock A)
   ocfs2_del_inode_from_orphan()
     inode_lock(orphan_dir_inode);  --> Line 2701 (Lock B)

ocfs2_move_extents()
   inode_lock(inode); --> Line 916 (Lock B)
   down_write(&OCFS2_I(inode)->ip_alloc_sem); --> Line 936 (Lock A)

When ocfs2_dio_end_io_write() and ocfs2_move_extents() are concurrently 
executed, the deadlocks can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
