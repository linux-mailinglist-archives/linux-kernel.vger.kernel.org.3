Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCF53BE26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiFBSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiFBSlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6113CE0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA99661702
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B92C385A5;
        Thu,  2 Jun 2022 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654195293;
        bh=BiBtVCnOnVCnBb/s+KIDqG6XVHJWq/doHqTwPsrqDDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wcfwJ2N6m6iYkyLPXAvxRttyDCvkGAqeByInXKFMdk9RkuPrnImtmzX0YBMzcdDw5
         1luGPe9SVVlz0r6sPFfRuMQgvEfILrNJZPihvvI2uKazI53rfhy38KX9b7BkUgtnMD
         CuPQREkUiB1ovWxFj1XxqayxFBkbwg4GW5TJpvyc=
Date:   Thu, 2 Jun 2022 11:41:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-Id: <20220602114132.f6e5675b2d2a4085b9b1e8c4@linux-foundation.org>
In-Reply-To: <YpgKttTowT22mKPQ@carbon>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
        <20220601032227.4076670-7-roman.gushchin@linux.dev>
        <20220601142351.5e04fea5586ca51898d8785f@linux-foundation.org>
        <YpgKttTowT22mKPQ@carbon>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 17:56:22 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> > 
> > > +	ssize_t ret;
> > > +
> > > +	if (copy_from_user(kbuf, buf, read_len))
> > > +		return -EFAULT;
> > > +	kbuf[read_len] = '\0';
> > > +
> > > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> > 
> > Was it intentional to permit more than three args?
> 
> Good catch! No, of course it wasn't intentional.
> 
> Below is an updated version of this patch.
> 
> ...
>
> +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 2)
> +		return -EINVAL;

s/2/3/methinks?


