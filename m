Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDE496D97
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiAVTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAVTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:19:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F5C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=iFBuaE4otMAYJfH5b2i7kwfnQaRdpq/cX0lkHyia+Vg=; b=V/ipXv88zeDj4TChE7RqFhRWiQ
        U5+c8xRykqDGFDIejnR8q/m6SPqxhzouvBS+7CGQC+Bip6LvDXPqczynU4ObOfaWgSUolNlCaxqbT
        xo15B8j8soJ0OCaLBKA0yQJ8/hdxQoX6oe647aernEjOquqKfaw11sStEcMSqveKD1X6fFIzW0sQD
        DwhcKZlVQ9X5twVsdXv/GbAk6ekStTxeA/sWxGTD8k5bz6OXPiZXQBNCE/LdoGj7kEkRWUZd6f5Be
        d1Sk1ChJ6zy6L736QVnWeX4Ijji5fU/9v64vOQG85vZm3oPatlybVFaULxJoay9ajZ7xbY7y2ZnmO
        hn/YtDwQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBLua-00GYkG-TV; Sat, 22 Jan 2022 19:18:57 +0000
Message-ID: <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
Date:   Sat, 22 Jan 2022 11:18:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
References: <202201221028.YKA8kSdm-lkp@intel.com>
 <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/22 10:28, Alexander Aring wrote:
> Hi,
> 
> On Fri, Jan 21, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   9b57f458985742bd1c585f4c7f36d04634ce1143
>> commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
>> date:   3 months ago
>> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220122/202201221028.YKA8kSdm-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.4-dirty
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
> 
> I have it on my list but it isn't easy to make sparse happy here...
> this is the second time the robot reported this issue. Is there a way
> to turn the robot off in that case?
> 
> Maybe some human who reads that knows the answer?

Hi Alex,

In the source file, you can surround the "offending" line(s) with

#ifndef __CHECKER__
 ...
#endif

to prevent sparse from checking those lines.
Sometimes there needs to be an "#else" branch also.

'git grep __CHECKER__' will show you quite a few other examples.

kernel test robot might have a different way to disable this test
for a specific source file. I dunno.

-- 
~Randy
