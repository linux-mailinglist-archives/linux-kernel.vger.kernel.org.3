Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED25318F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiEWTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiEWTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:23:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291F4D9C5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:02:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gg20so14865854pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E+e32v9CzxQa93MuecjYcAl4MrJrUxsLwkgEEqSuqtM=;
        b=QfXP5NKYiyRZfe7w+ofu3dxvuhPe93hUIjE/XrMJGdpSxTBQ2Z3ETyrXtw8Fh/SoD3
         aH7o+Kk5AXDVkVCW9cEhEy+Z28+MQSrX+mRKYPBM5OjwEih7rxLROLxG6v+xf09Bziq8
         YJTCXwTgWFBvMAlyhW6XrIzWuMTkkRqIYEl/O6ZDs9z9c0QaJ3hpRMQZakJ/CBrnGfZF
         8y9iOc2xt8pg28OoV5x1jxW8/9VcCf/EgR0OxJj2vFbAba04sAyQv9jadr8w9zny0mMq
         jdsG/WbD2BNu/bbtBo5edqE+WckyuG0tn7YqM49FBxXKXau/48wlmp/E7PRyYM/dGMAj
         RRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=E+e32v9CzxQa93MuecjYcAl4MrJrUxsLwkgEEqSuqtM=;
        b=Wdjra/BagAhmhOCb/Md0MbeQjwsAeIRI39AEc0uT0qFj7pEO+CJOTvEW20h4K5Ozst
         qP4wA1ehwHKmNXr8RTm01D2NntH4n8MLZycwth4nKqWUu+d1/xRAujbvNZ4QPTOzRPu9
         TzjCBs91JvmiOpvq+P1Gl5dpMCgSg2pl1A0QjxK+y2yEF28FyTPEUlzdM3J+y578AjEe
         s6hBiBrA5DW/GV+inTY+TVWOj3i9YmRPIO0JVR2B+pprvVLE2QV3qF7FD5X65TM/a3LC
         /OF4YqK9RwpGJnCphO6An4DlKfz3vd3IjnpLF0zZUUyRs/vWZY4ycg2QLz3nRdXle6IF
         bAAA==
X-Gm-Message-State: AOAM532JerR8L4heCwWRoZPpIme+SnPglzm/1nvqjywA87G80F22C68h
        ADVyXyjrk0Gbe+v9Q+yL2zNGeZ1OmSw=
X-Google-Smtp-Source: ABdhPJwh6WwDcHYZJVqBdUBDIQbwAXKCGur4bgSqK/KdrW35qQgR8P8rfwbI4tF/vxDCjFNgeUSaVw==
X-Received: by 2002:a17:90b:4a8c:b0:1df:c71d:5104 with SMTP id lp12-20020a17090b4a8c00b001dfc71d5104mr434254pjb.216.1653332523613;
        Mon, 23 May 2022 12:02:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id g20-20020a625214000000b0050dc76281c4sm7528877pfb.158.2022.05.23.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:02:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 May 2022 09:02:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Message-ID: <YovaKZV7IzQgCo9E@slm.duckdns.org>
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz>
 <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
 <20220520164255.GB17335@blackbody.suse.cz>
 <6ac66e89-2063-c5e8-df15-f77b76befc05@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ac66e89-2063-c5e8-df15-f77b76befc05@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:00:06PM -0700, Tadeusz Struk wrote:
> On 5/20/22 09:42, Michal Koutný wrote:
> > On Fri, May 20, 2022 at 09:38:12AM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> > > as this is a result of enqueuing the same css->destroy_work onto the same WQ,
> > > one on the rcu path and one on the css_release path.
> > > I will prototype it today and test with syzbot.
> > 
> > In my understanding, you'd need two independent work_structs in a css,
> > not two separate workqueues to put the single entry on.
> 
> Yes, separating the css_killed_ref and css_release paths with two separate work_structs
> fixes the two syzbot list corruption issues [1]&[2].
> I tested it on mainline v5.18.0 and v5.10.117
> In case of [2] the mainline triggers an issue, but it is unrelated to list corruption.

Can you try holding an extra ref in the killed path?

Thanks.

-- 
tejun
