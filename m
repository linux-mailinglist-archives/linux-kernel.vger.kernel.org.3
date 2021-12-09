Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516B46E25E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLIGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLIGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:24:24 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F87C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:20:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 7so7288853oip.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mQ7hWd5y/cX7pLN703rPlCh10s+JfDxjIeGD1iE5U+w=;
        b=VVd/Vy0aUpLV0wPA3tkVRJTPDJumIspBWsIUMUZqp3ogZzhlejrhrOoacWWRRXOKBP
         2z28YaLT09BCFeUkUE/GZKFsxieiuhxkBuJkE+L3PfEqi6CplG7A9tBKK2tZ2nLSC/6q
         wo4Orp1r0FrIv0piod0w/ATkSOGZI6qnoK2WPNPZaZDH7WX+yhjXACOAR0KUkAurt+2p
         9biAtg6Vd/vWcAq0ysww0v1zO26wH6ZyQheczyWkWibHPulj/VF0oVCtKY0YQCu7KiS9
         0Dk+TskA4as/z/+0PbT8KezyiZFQcvOTAYWepspIEcuwflYWqs6aF8NF7mrtRAXIj6I+
         44bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=mQ7hWd5y/cX7pLN703rPlCh10s+JfDxjIeGD1iE5U+w=;
        b=kTkmvneaR2S+zf/Nqs19iWBhW79IwBvWgS47CmNcznsdjTOrHASVoZ9y0ULaY2ANCp
         7xatgelpp3eL8TJEr8C7Yk5g9q5Gsw9/A9/e45uUpGGhy8NodYODQhreFS5gyd3/VMOD
         i0LVCvTrHLIzjkpkXN8sUD2rHJeZV97gM5DlJK5U2IUVAJBE6s7W0rbkN5/OaPc7GjlS
         GJnKwmGZSgRzym8E77o6C7a4YMVkmZvCXanbCOPN04BZX2EzsiwGk7wwTGBjGaT4CRYT
         keAn++FAzPGH4/+enytEsQfNWhjsXSsxSUnS0nMYhBgPKDx3A4vtE7LJ8I4l0l8nOYtU
         tpTA==
X-Gm-Message-State: AOAM531NpxqbEoQWraY4l8kateReBxc4RBVYx8MkgVS9naREne1ksGew
        wurJT880eAMDMzbuIb31H5Gy8g==
X-Google-Smtp-Source: ABdhPJw9OPID56vDdJCFPIcuD4PvDWMFAxEx/AK93Z9FXNeZLG/dSHWRSGT0eS42J2loD9GXN3YCjA==
X-Received: by 2002:aca:2207:: with SMTP id b7mr4219069oic.24.1639030851177;
        Wed, 08 Dec 2021 22:20:51 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t14sm919606oth.81.2021.12.08.22.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:20:50 -0800 (PST)
Date:   Wed, 8 Dec 2021 22:20:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure
 to make progress
In-Reply-To: <20211202150614.22440-1-mgorman@techsingularity.net>
Message-ID: <df896d80-9972-5be-55c2-c5b0c7135d4b@google.com>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021, Mel Gorman wrote:
...
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
...
> @@ -3478,14 +3520,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			/* need some check for avoid more shrink_zone() */
>  		}
>  
> +		if (!first_pgdat)
> +			first_pgdat = zone->zone_pgdat;
> +
>  		/* See comment about same check for global reclaim above */
>  		if (zone->zone_pgdat == last_pgdat)
>  			continue;
>  		last_pgdat = zone->zone_pgdat;
>  		shrink_node(zone->zone_pgdat, sc);
> -		consider_reclaim_throttle(zone->zone_pgdat, sc);
>  	}
>  
> +	consider_reclaim_throttle(first_pgdat, sc);

My tmpfs swapping load (tweaked to use huge pages more heavily than
in real life) is far from being a realistic load: but it was notably
slowed down by your throttling mods in 5.16-rc, and this patch makes
it well again - thanks.

But: it very quickly hit NULL pointer until I changed that last line to

	if (first_pgdat)
		consider_reclaim_throttle(first_pgdat, sc);

I've given no thought as to whether that is the correct fix,
or if first_pgdat should be set earlier in the loop above.

Hugh
