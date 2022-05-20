Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5752F0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351798AbiETQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351792AbiETQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:45:16 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91734178567
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l82so2593661qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8xIXPdHqKY/S928N5n4lpCrih7fBjePFCe31Nm3HEU=;
        b=cmvcEGmOVBjFBzLUYaEoVPYa92JOWcLZT3qRym44KayCXwLx04F/hGWoRYq1fVPgWb
         kk+veu9Clf2Pyaf1Sualbrjs0o5wb0jBTUi8V6HVNLuIlyQqwBVgTnw0axO1k2FFk7uQ
         X/80AU7Lx2CF4AgaVK+O1TFCih8iAo8Xoaiwd61pFQfUQH7UjYenW87j8ScDLjAn1RH/
         c9V1ZImHn8kP/4KarRbzdR2vJr1x+nkui06a8fminuD3r4SnkDmRI/otkV1FzyPeQ+V4
         ZOarhhNpCNPoDXaxUnq2AR68aQIplxZETm1Hz7bT7aU4Y/PiMjarNWA5keH7cmMldiD2
         SeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8xIXPdHqKY/S928N5n4lpCrih7fBjePFCe31Nm3HEU=;
        b=maHou4BA6JdQqK1x+5lG62eYTNg6M0GPN2JRbGzmOab3Q/HB1bunILoiLzQclDx+yd
         0CvMcc+5IUiwbNjYbnHRNXAOcv//W2Yg83GGd1c4AcNKU6NWClhFHdNJZC8Ofwi2+5eh
         HooUfb+uyVEqCrP8VCj2Cb/ty1zHmw3u+o22QiiB16LPFlhKcmZehUeUKAfi5uyaLoBE
         nZUufEBp6P3unrxapLLfGlYxLhNIKErOJ3Weo6w+OvP/IioVTK5RgyxgOxplATqwG+wS
         t+4GX+mNf6dbnPK2Mc/846TLXE8NhHwrOgEbhvkJ9+CfWce+Hm/pLCYBgjZ9RPmoU1fI
         SrPg==
X-Gm-Message-State: AOAM533YqcyPNeoLFfxTIPzBqhj0VGyV+pKDZp7iFttccOqi5w9ZOMrH
        hw/ru07MiKz3tlgddSK8EQ==
X-Google-Smtp-Source: ABdhPJyKLOM4Ryqhmi5CW9j0Bz6v9+5ljLoMoiDX4xitkxq7asAc2Y5lcbyIGJGXCejQlR6E/nj4FQ==
X-Received: by 2002:a37:5805:0:b0:69f:c640:f5e8 with SMTP id m5-20020a375805000000b0069fc640f5e8mr6794806qkb.586.1653065114732;
        Fri, 20 May 2022 09:45:14 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id h198-20020a379ecf000000b006a33f89bb00sm2470514qke.81.2022.05.20.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:45:14 -0700 (PDT)
Date:   Fri, 20 May 2022 12:45:12 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <20220520164512.dqqbb5gkmfm6f4g6@moria.home.lan>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-3-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:16AM -0700, Roman Gushchin wrote:
> This commit introduces the /sys/kernel/debug/shrinker debugfs
> interface which provides an ability to observe the state of
> individual kernel memory shrinkers.
> 
> Because the feature adds some memory overhead (which shouldn't be
> large unless there is a huge amount of registered shrinkers), it's
> guarded by a config option (enabled by default).
> 
> This commit introduces the "count" interface for each shrinker
> registered in the system.
> 
> The output is in the following format:
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> ...
> 
> To reduce the size of output on machines with many thousands cgroups,
> if the total number of objects on all nodes is 0, the line is omitted.
> 
> If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> printed for all nodes except the first one.
> 
> This commit gives debugfs entries simple numeric names, which are not
> very convenient. The following commit in the series will provide
> shrinkers with more meaningful names.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

I think this looks reasonable

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
