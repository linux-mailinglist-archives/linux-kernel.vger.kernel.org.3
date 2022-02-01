Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE04A573F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiBAGdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBAGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:33:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF27C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:33:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j23so31929325edp.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JrzOIwB/15hXdxo9+BD6kYpDhXtGeAQrIT7/EdNyUC8=;
        b=KiOB8OZmozPHe204e845yU6DhE2s2Wii7ARJYDMRtL14WMcLChXIhgUC8V7Sc6qv3c
         ygZAa9odMWs+SHECpaMYcYiFX2RKQgy2gueKBEfcNJ2YNd06zKBuVOk2+wzrG2OV99vd
         4sLfTzxmDxzPh4V6Wq2X0aTg65IbvVqX02+Ez5Ubeld3riS+YfNItXkYYbyoFQQRp4tO
         dNJSQ0LVj5ZatkwM46bWaMzeU3p9gwsJVctEqK2BJvWb2IIzwTsTNzmGniU3pC1eR8hP
         3aQWB6BGEjSe11DSbIpQAn7imGk3yayzkeSqRzjHIs5hxqewKmSPM4FEPgPLBrc2wHZy
         rOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JrzOIwB/15hXdxo9+BD6kYpDhXtGeAQrIT7/EdNyUC8=;
        b=YhAkelgNO0J2aso88eyW14OJXWVgo0ji/dt3VInqfcI2lwOgAx3IJ9CuiSMqbKix2p
         E93FCnIcZ20WBmWAo42B36oAn8+2LQ1GH4fw/VxQNBHU1qaIece9FuVM7eDEOyNsKmcp
         vqqK0eD3tA4Dr9zpO4saB3o6DKZT2wKc75qE7OVQ+03+aekqTjxQKpp8vCrItfIP0N2t
         dEvUgBhG0ZjsWKQcf1TchN/t8xyBfZm7uytGMW5D8GSgDlunEv9JiNPMHqG4I+jTNUTR
         EsvIm27wdyeFIj/RXZQ5HyJ8caGQa1QH8u3Hj5gkZRR7630lO9ZKEhq5h2ZWR5NTNi1s
         Q7QQ==
X-Gm-Message-State: AOAM532J2PL8KCH2S3S0qWkQDzKM4wFfUEAPJlwaiSjYE6GrlrgLCEk/
        KZnJVV+UAXYVB0PWIwm3pCY=
X-Google-Smtp-Source: ABdhPJz0L77NhTpN2CaRbV3UMUQngiAZFds2CfrdJ3MxZAJnDbRhUE2zdRKHZYmco5hzlmHATJSNsw==
X-Received: by 2002:a50:eb82:: with SMTP id y2mr23327756edr.133.1643697219722;
        Mon, 31 Jan 2022 22:33:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id fh23sm14300698ejc.176.2022.01.31.22.33.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 22:33:39 -0800 (PST)
Date:   Tue, 1 Feb 2022 06:33:38 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <20220201063338.u4ux2jsgctuo7tex@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <YfJXoSVkQ3X5u44F@dhcp22.suse.cz>
 <20220129002628.2cwr35glahq5f5md@master>
 <Yfe48O7eBWSe0LjK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfe48O7eBWSe0LjK@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:24:48AM +0100, Michal Hocko wrote:
>> >> This patch restore the original behavior by using the same criteria to
>> >> add a zone in zonelist during memory hotplug.
>> >
>> >Why?
>> >
>> 
>> In case we online a populated zone, but not managed. Then this zone will not
>> be in zonelist. Right?
>
>yeah. We can theoretically end up with a zone without any managed menory
>on the zonelists. But my primary question is why do we need this change?

Currently I don't see a real case for this.

>Does it fix any existing problem? Does it make the code easier to
>read/understand? Does it improve performance? Every patch should have a
>justification. Your changelog merely lists the history and then states
>the new behavior without any explanation of why that is needed or
>desired. See?

I don't have such reason now.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
