Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C04787FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhLQJnc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 04:43:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:21864 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234541AbhLQJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:43:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303097637"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303097637"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 01:43:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683327383"
Received: from kmcgonig-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.8.181])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 01:43:23 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: transform documentation into POD
In-Reply-To: <87h7b8cfg0.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211209225549.69010-1-tomasz.warniello@gmail.com>
 <87h7b8cfg0.fsf@meer.lwn.net>
Date:   Fri, 17 Dec 2021 11:43:18 +0200
Message-ID: <87k0g336tl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021, Jonathan Corbet <corbet@lwn.net> wrote:
> Tomasz Warniełło <tomasz.warniello@gmail.com> writes:
>
>> The only change in the script execution flow is the replacement
>> of the 'usage' function with the native core Perl 'pod2usage'.
>>
>> This entails:
>> - an overall documentation restructuring
>> - addition of a synopsis
>>
>> Otherwise my intervention is minimal:
>> - a few tiny language, formatting and spacing corrections
>> - a few missing bits added in the command syntax description
>> - adding subsections in the "FORMAT OF COMMENTS" section
>> - alphabetical sorting within OPTIONS subections
>
> So I think that this is generally a good thing, but I do have some
> quibbles.  Starting with the above, which is a pretty clear violation of
> the "each patch does one thing" rule.  Please separate out your changes
> into separate patches so that they are more easily reviewed.
>
> A few other things below...

I'd throw all code comment formatting documentation out of here, and
restrict the script to describing the command-line parameters only, and
focus on Documentation/doc-guide/kernel-doc.rst being the single point
of truth for comment formatting.


BR,
Jani.

>
>> Finally, the TODO stub evolves into a section:
>> - perldoc request removed
>> - undocumented options added
>>
>> Run `kernel-doc -h` to see the full doc.
>>
>> The TODO suggestion is ancient, thus I can't address its author with
>> a "Suggested-by" tag.
>>
>> Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
>> ---
>>  scripts/kernel-doc | 613 ++++++++++++++++++++++++++++++---------------
>>  1 file changed, 413 insertions(+), 200 deletions(-)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 3106b7536b89..00c0c7f5ff58 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -4,46 +4,33 @@
>>  use warnings;
>>  use strict;
>>  
>> -## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
>> -## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
>> -## Copyright (C) 2001  Simon Huggins                             ##
>> -## Copyright (C) 2005-2012  Randy Dunlap                         ##
>> -## Copyright (C) 2012  Dan Luedtke                               ##
>> -## 								 ##
>> -## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
>> -## Copyright (c) 2000 MontaVista Software, Inc.			 ##
>
> My immediate reaction is that you shouldn't be removing copyright lines,
> though I did see that you put them back later.  I think, though, that
> the copyright assertions should remain at the top of the file; they
> don't need to be part of the help text that the program emits.  So leave
> them here, please.
>
> (I guess I should add one of my own, assuming I want any part of this
> file actually associated with my name...:)
>
>> -## This software falls under the GNU General Public License.     ##
>> -## Please read the COPYING file for more information             ##
>
> This could come out, though; that's what the SPDX line is for.
>
>> -# 18/01/2001 - 	Cleanups
>> -# 		Functions prototyped as foo(void) same as foo()
>> -# 		Stop eval'ing where we don't need to.
>> -# -- huggie@earth.li
>> -
>> -# 27/06/2001 -  Allowed whitespace after initial "/**" and
>> -#               allowed comments before function declarations.
>> -# -- Christian Kreibich <ck@whoop.org>
>> -
>> -# Still to do:
>> -# 	- add perldoc documentation
>> -# 	- Look more closely at some of the scarier bits :)
>> -
>> -# 26/05/2001 - 	Support for separate source and object trees.
>> -#		Return error code.
>> -# 		Keith Owens <kaos@ocs.com.au>
>> -
>> -# 23/09/2001 - Added support for typedefs, structs, enums and unions
>> -#              Support for Context section; can be terminated using empty line
>> -#              Small fixes (like spaces vs. \s in regex)
>> -# -- Tim Jansen <tim@tjansen.de>
>> -
>> -# 25/07/2012 - Added support for HTML5
>> -# -- Dan Luedtke <mail@danrl.de>
>
> These, too, should come out; that's what the git log is for.
>
> [...]
>
>>  my $kernelversion;
>> @@ -468,7 +306,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
>>      } elsif ($cmd eq "Werror") {
>>  	$Werror = 1;
>>      } elsif (($cmd eq "h") || ($cmd eq "help")) {
>> -	usage();
>> +			pod2usage(-exitval => 0, -verbose => 2);
>
> Why the strange indentation here?  This file is far from pretty, but
> that makes it worse.  (Other places too).
>
> [...]
>
> Thanks,
>
> jon

-- 
Jani Nikula, Intel Open Source Graphics Center
