Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6335487D53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiAGTvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiAGTvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:51:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312AFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:51:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x6so19301783lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZDmCDAiYhTVuYUfs3SOTkjNWRZtD7CTjS5SbmPGZLuU=;
        b=jfH0M6K4Vh7EewiEUOo5i+vjV7MPS0tINGb/bOkKWbyLMZ2XWFQnkth82BBRSkuPYf
         KwSzZLVJeSakNWMcia+1csd3c4jDsc7BiXZ1b2AxdymDdeLtVXpjOlk/Lt6P1sFilDGu
         RkZScypj4+pqPKYt4duZs6YEg/y/TA1ODq35CzT7FsqXlgJEEeAehT7Qy/I2JjMGdmi5
         ryJPORcn8Tds6/QJ1TtJS8y26M91PtGBTpMQutqqF56/cOa7VOWj49h43XRonhwmL49y
         eVhu4egh5V3NvZ8csGhkdvNKnqgtQkeIR1OAet6Fq5VnLOX0ad17pGDDEE16bNcIgdCk
         W+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZDmCDAiYhTVuYUfs3SOTkjNWRZtD7CTjS5SbmPGZLuU=;
        b=kgSvw+ILIikS/VpDF/pQU6iscLu8NMJNy8/2FgCWlHGd2+EWth9VpnKA6TW4trkty7
         tJXXWETQMX5EcFry4C/Vq5Jv3DSaOQ70rO8XtjRHfyVs4ECu2vkDdZfk3iHfl1z5zG9n
         pw4o1Bb8J+S3sSniTKDG3Rn9+APh7BKiyiRjj2lfBSfbM3OhoFh9krwTJpwQ6sd5ltE6
         PvPVHgmd4o4/fhhticvmoo0qtZjt/WmADfSWlt0dldAX+eDh02ILPoBgy0poRZI2Qxcd
         6ajawhKnG3ToK634dRUw/7kdPDPDm9jN9qGmxEBD5ykeDQqUcHz73hvqOAE+T89gia+D
         eaPg==
X-Gm-Message-State: AOAM531CA7dxzPwHlogkbYIArAH3zWiBg7fNbyKT5Wj1NoOdu04WUOkE
        YZMOLcUrunD30py36ODPgvfRnR3BaBI=
X-Google-Smtp-Source: ABdhPJwwMBBRiteixwLwk6cfyZIZFQaMZnHzN5OvYQcGYjuT+m9aW6r1U2r+vhKGfeVf2vWhZ3i4PQ==
X-Received: by 2002:a05:651c:201c:: with SMTP id s28mr51124851ljo.316.1641585110323;
        Fri, 07 Jan 2022 11:51:50 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id y20sm691745lfa.131.2022.01.07.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:51:49 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 71C895A0020; Fri,  7 Jan 2022 22:51:48 +0300 (MSK)
Date:   Fri, 7 Jan 2022 22:51:48 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, caoxiaofeng@yulong.com, david@redhat.com
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
Message-ID: <YdiZ1BZ7gyMaJQCz@grain>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain>
 <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 01:04:51PM +0100, Christian Brauner wrote:
> > 
> > Wait. The userspace may pass old structure here, and in result we
> > return incorrect layout which won't match old one, no? Old binary
> > code has no clue about this header update.
> 
> Yes, that won't work as done.
> 

Yup. When I've been developing struct prctl_mm_map I reserved
PR_SET_MM_MAP_SIZE opcode so userspace would be able to query
current structure size and provide memory slab needed to fit
running structure.

As far as I see we can cut off some space from padding (at the
end of the structure) though one need to make a precise check
that there is no alignment holes appear on different architectures
other than x86. This area is pretty sensitive.
