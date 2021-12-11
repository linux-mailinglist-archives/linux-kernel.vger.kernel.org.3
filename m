Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA76471497
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhLKP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:58:01 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:9000 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhLKP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:58:01 -0500
X-Greylist: delayed 695 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Dec 2021 10:58:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639237557;
    s=strato-dkim-0002; d=schoebel-theuer.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=PBlFu+wsThkymIMAFq4AB4JTJ9Of5haIcw9PRdsiO0o=;
    b=cJ6JKzYai20jnurxW1YYQFuqqZa97ogddbNTI2d1+Uc8hQwotvMp0DG+zc6EdJXJ2Y
    kD4AEW8AY7E9K5IHjGOoQUzpOKO7DcRSLWGJyjsRsgzdgRrxeKD2OMruc16NZwUjNxlL
    R7luu2qp5yaUwUkEdIq4KXP643IXudwZgpIF7qRGBIrggCJQpYMq6+zUH4dStS7kXmX4
    LAyvBibcPfXuumDJx8CkWMyXZWTRJEexD7t2LJhCui10j9I0isIDKIDNZRmtNsV0wpOf
    /hjM1D9VxLIwpLPtA7mWPtJKRFOnqOYhGoaurpG+zlTmyezM+tyD9TqUnzqRs3YpiTZa
    a+zw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMbfOob5IoQoyC2I0MN+jr"
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.102]
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id x08697xBBFjt8HI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 11 Dec 2021 16:45:55 +0100 (CET)
Subject: Re: [PATCH v43 00/15] /dev/random - a new approach
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Tso Ted <tytso@mit.edu>, linux-crypto@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
From:   Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Message-ID: <f59e7a25-ea0b-b36e-791e-8ab49bc7102c@schoebel-theuer.de>
Date:   Sat, 11 Dec 2021 16:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/21 5:39 PM, Stephan Müller wrote:
> The following patch set provides a complete production-
> ready and yet different approach to /dev/random which is called Linux
> Random Number Generator (LRNG) to collect entropy within the Linux kernel.
> It provides the same API and ABI and can be used as a drop-in replacement.

My suggestion: please name it /dev/fastrandom or /dev/fips-random or 
/dev/scalable-random or whatever is appropriate, and please leave the 
traditional /dev/random as it was for decades.

My reasons:

I am one of the downstream kernel responsibles you might affect with 
your changes. I am responsible for any kernel issues for millions of 
customers.

For me, the _slowness_ of the traditional /dev/random is a _feature_.

Some more detailed arguments, important for my use cases as seen by me:

1) Personally, I have made some 1&1-internal scripts which don't rely on 
a single source of entropy, as seen by sysadmins. Note that each 
/dev/$other_random is a _single_ _source_ of entropy from a sysadmin's 
perspective (and also a "blackbox"), although the role is different from 
a kernel developer's perspective.

2) Any new kernel must be able to run on any of our machines, even very 
old machines (bound by old customer contracts) which don't have certain 
hardware features, or have a different non-functional behaviour like 
performance, or interrupt timing behaviour, etc. Thus the non-functional 
behaviour of the traditional /dev/random is important for me. Please do 
not change it.

3) Whenever a new kernel behaviour is "discovered" by some userspace 
developers (whether in-house or from many OpenSource projects around the 
world), they tend to use it sooner or later, for whatever reason. If 
suchalike would happen at the traditional /dev/random, it would be 
noticed by some of our sysadmin teams. Here is the reason:

4) Collection of entropy vs consumption of entropy: the old /dev/random 
has an important feature for me: any _mass_ usage by whatever class of 
users (whether tenthousands of UIDs per server and/or HTTP/second, or 
maybe even some privileged orchestration scripts) would _consume_ masses 
of entropy. When suchalike consumption would exceed the production rate, 
the old /dev/random would become so slow that our internal monitoring 
processes would certainly alert, and consequently would hint our 
responsibles (located at other teams) at the problem. Traditionally, 
/dev/random and /dev/urandom are thus used for different purposes.

5) Please don't misunderstand me: I am _not_ against the bazaar model 
which allows you to develop new and interesting features. Just don't 
throw away the traditional solutions, encapsulating huge amounts of 
manpower. Please create a new booth at the bazaar. Then some hundreds of 
userspace developers can support the new solution, or even  migrate from 
traditional interfaces like /dev/urandom to newer ones. Many userspace 
projects are widely distributed, and independent from each other. By 
providing a different interface (which is easily detectable), separation 
of concerns will become easy in a worldwide scale.

Hints: whenever changing / improving non-functional properties of your 
new /dev/$new_random, please report _separate_ version numbers for 
non-functional vs feature versions. Please maintain it over many years 
(hopefully comparable to the lifetime of /dev/random). Please long-term 
document the rules how its new features should be _interpreted_. Please 
document important use cases. Please create a better documentation than 
the traditional ones, also understandable by sysadmins (not only by 
certain developers or security experts). Even more important: please 
document and depict _scenarios_ where certain features should _NOT_ be used.

Cheers and very sincerly,

Thomas

Homepage: https://github.com/schoebel and look into the mars/ project 
and also into its docu/ subfolder. Please read the big pdfs. Then you 
might notice that I could become a potential future user of your new code.

