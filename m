Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1851898F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiECQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiECQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:23:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D82C64D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:20:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so6768845otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfrAvdzMCVZFNr1VGcMbw6Nne+rB0bgZkaiibREqMIU=;
        b=bjX47vSczG1UpwH3woF/YW1tOq4qwOigdHqC8RnYt8ontvKStM/OyGy6Fg4gb/gOBd
         aiqht5tAc9gdlWq600yIp3edBd36547azxQvtgNA//tbrO39YIcdPwAtKWqmNcOB71Sg
         8xVeZ834lbX3e90FUK3DATi0XMfR8tTasux+j/T1OjkSaPOIh9yTlvfWWSkfwDaLPCPE
         Lny6fgHDdw84kBu5jCnf5esY0y48lkdDrHJ6NMY5HaDrUWobWG0hltWpfBzeIwJ786x7
         FdCvX6IxoV6MYoZKZeaBBU9DR6N7LnUB6mARk+X39bCaaLlwQGfOZuDU7Lgx9LHAt1cy
         7SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfrAvdzMCVZFNr1VGcMbw6Nne+rB0bgZkaiibREqMIU=;
        b=KhCjM4tMek5W8qmrr+OMhOdrZ965pR+vVpNPgskNLvrt3nJ5+g3vqi24r2J2IkP62f
         z8zH8r2rki23k0vh6mBxSZZX3+9UdY0R1tLaXGb6VXqCwLgvvLzTbxPJ4eefnWSq/oF3
         8jSgnuz9jSScTKl7FUCMEvg1Rd/DzGdWQ9c0NNrnWblh/ArrQtzMLRXBMLF/YAFMqXvO
         qOwUmVykcJgE41UnqZz8P5AIEB9wyMPZut5uihYaPxJPa7k04iSRgGw9ChsEg21+w70p
         B/rsqKmkvfd8Ia7b2gI2f4AiXYQFxDsvJgoQM0XbGAsJomSC32uq6VlmFhrFIAdK+3pn
         rY6g==
X-Gm-Message-State: AOAM532/HEzbAEkxa3r1Dw2nMDNxsA/qqj36DhabHtTAsGzuYBSFtWfv
        2XBZNQgKjybNe/e7fkJaOKuhdg==
X-Google-Smtp-Source: ABdhPJyf1vYXk/t1rih2OFKGuCF7QinnVRCE8lSe9hdTQjKHj2zYLNKr5Rv67OSeKwElMSDqc07dVg==
X-Received: by 2002:a05:6830:1183:b0:606:698:717e with SMTP id u3-20020a056830118300b006060698717emr5424639otq.309.1651594806311;
        Tue, 03 May 2022 09:20:06 -0700 (PDT)
Received: from localhost ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id k18-20020a9d7612000000b0060603221254sm4044642otl.36.2022.05.03.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:20:05 -0700 (PDT)
Date:   Tue, 3 May 2022 09:19:16 -0700
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: cache the result of node_dirty_ok()
Message-ID: <YnFWBLKJyl27NvyO@cmpxchg.org>
References: <20220430011032.64071-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430011032.64071-1-vvghjk1234@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 10:10:32AM +0900, Wonhyuk Yang wrote:
> To spread dirty page, nodes are checked whether
> it reached the dirty limit using the expensive
> node_dirty_ok(). To reduce the number of calling
> node_dirty_ok(), last node that hit the dirty
> limit is cached.
> 
> Instead of caching the node, caching both node
> and it's result of node_dirty_ok() can reduce
> the number of calling node_dirty_ok() more than
> before.
> 
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good to me. I like Andrew's naming fixlet as well.
