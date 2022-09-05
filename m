Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AD5AD327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiIEMo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiIEMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:43:43 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB9A19A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:42:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.42.181])
        by gnuweeb.org (Postfix) with ESMTPSA id 4BCB5804FD;
        Mon,  5 Sep 2022 12:42:38 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662381762;
        bh=tMI6JjeFMjJlCrUo8LzWO0H7i2bRYzrR9qmlHatGSaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b13HLykytDYMjniM7ng0VoqZBrssIWbb3Z0pfn5bMsAZqWbLrSE7TtasJwA+P8Vbn
         zurSCS7o6KJ4HRhKi7NNk9WTvYErzDr2rERd4OA+76xsxadORMm3UiDtnnL+YpreEb
         XcHzlEHfaW1hxfv3sDdltfu3N8sVsCpXZ+/QeiWJAOyd5U2yLUkDptGpjRRfmiC0GC
         IRUXVOmc6DR0uhb5xGZBkzcFBwlDBqrZiYTEVQXLcH++/niIqYvosTvQKfrR5Ng1KI
         k/sUAq4CR22tuNJQtbHwvUXAOCLAbdhj3JLsy2H2b56VuQ8+J8mQKqw3N11Dk6ELld
         FMsTCcUW3J+9w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management Mailing List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Mon,  5 Sep 2022 19:42:34 +0700
Message-Id: <20220905124234.635349-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YxXlQWy8LLEy6rcD@dhcp22.suse.cz>
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-4-osalvador@suse.de> <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org> <YxXd9qXnIutFOQZY@dhcp22.suse.cz> <20220905115459.567583-1-ammarfaizi2@gnuweeb.org> <YxXlQWy8LLEy6rcD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 14:02:09 +0200, Michal Hocko wrote:
> On Mon 05-09-22 18:54:59, Ammar Faizi wrote:
> > On Mon, 5 Sep 2022 13:31:02 +0200, Michal Hocko wrote:
> [...]
> > > > static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > > > 					  size_t count, loff_t *pos)
> > > > {
> > > > 	char kbuf[21];
> > > > 	int ret;
> > > > 
> > > > 	count = min_t(size_t, count, sizeof(kbuf));
> > > > 	if (copy_from_user(kbuf, buf, count))
> > > > 		return -EFAULT;
> > > > 
> > > > 	kbuf[count - 1] = '\0';
> > > > 	ret = kstrtoul(kbuf, 10, &threshold);
> > > > 	return ret ? ret : count;
> > > > }
> > > 
> > > Isn't there a proc_dointvec counterpart for debugfs?
> > 
> > Ah, well. If that's much simpler, we should go with that. I am not
> > familiar proc_dointvec() interface, so I couldn't say about it.
> 
> Just to clarify. proc_dointvec is rather specific to proc/sysctl
> interface. I was too lazy to look whether debugfs has something similar
> available. Maybe writing to debugfs is not all that common but I would
> expect a shared code to write a simple value would be there.

I took a look, there is DEFINE_SIMPLE_ATTRIBUTE().

Ref: https://github.com/torvalds/linux/blob/v6.0-rc4/include/linux/fs.h#L3458-L3487

It looks much simpler to me. Untested, but it is something like this:

-----------------
static int page_owner_threshold_get(void *data, u64 *val)
{
	*val = threshold;
	return 0;
}

static int page_owner_threshold_set(void *data, u64 val)
{
	threshold = val;
	return 0;
}

DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
			&page_owner_threshold_set, "%lu");
-----------------

And then the init should be the same:

	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
			    &proc_page_owner_threshold);


-- 
Ammar Faizi

