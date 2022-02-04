Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042884A9A49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358992AbiBDNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:48:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358974AbiBDNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:48:29 -0500
Received: from [192.168.254.13] (unknown [72.85.44.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id 61BF620B6C61;
        Fri,  4 Feb 2022 05:48:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61BF620B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643982509;
        bh=ktb8h9R2FuGUyuu9vO9Aa8piTeN/08pchayZa5eu6lk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p3Fr5MwT84Q/eBBwJnd/CQVTLGRVSKlAHI0GEQ+5PJBai5jjczGYSBhPEDE0hMMT+
         iGik3TOfzFt6UYY7Po5phyFVVMRww2etepcYC0/L87Au2iSUW+ZiZX1I+O26yfJCU/
         UpG5IDqdt89rfFtbXHxI/wkwjmpvDmDYmdjgnVvU=
Message-ID: <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
Date:   Fri, 4 Feb 2022 08:48:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
 <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com>
 <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com>
 <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
In-Reply-To: <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2022 18:44, Paul Moore wrote:
> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.com> wrote:
>> On 2/1/22 12:26, Paul Moore wrote:
>>> On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
>>> <demiobenour@gmail.com> wrote:
>>>> On 1/26/22 17:41, Paul Moore wrote:
>>>>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
>>>>> <demiobenour@gmail.com> wrote:
>>>>>> On 1/25/22 17:27, Paul Moore wrote:
>>>>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
>>>>>>> <demiobenour@gmail.com> wrote:
>>>>>>>>
>>>>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
>>>>>>>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
>>>>>>>> descriptor being leaked to a process that should not have access to it.
>>>>>>>>
>>>>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>>>>> ---
>>>>>>>>   security/selinux/hooks.c | 5 +++++
>>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> I'm not convinced that these two ioctls should be exempt from SELinux
>>>>>>> policy control, can you explain why allowing these ioctls with the
>>>>>>> file:ioctl permission is not sufficient for your use case?  Is it a
>>>>>>> matter of granularity?
>>>>>>
>>>>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
>>>>>> files.  If I want to allow them with SELinux policy, I have to grant
>>>>>> *:ioctl to all processes and use xperm rules to determine what ioctls
>>>>>> are actually allowed.  That is incompatible with existing policies and
>>>>>> needs frequent maintenance when new ioctls are added.
>>>>>>
>>>>>> Furthermore, these ioctls do not allow one to do anything that cannot
>>>>>> already be done by fcntl(F_SETFD), and (unless I have missed something)
>>>>>> SELinux unconditionally allows that.  Therefore, blocking these ioctls
>>>>>> does not improve security, but does risk breaking userspace programs.
>>>>>> The risk is especially great because in the absence of SELinux, I
>>>>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
>>>>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
>>>>>> a file descriptor can be leaked to a child process that should not have
>>>>>> access to it, but which SELinux allows access to.  Userspace
>>>>>> SELinux-naive sandboxes are one way this could happen.  Therefore,
>>>>>> blocking FIOCLEX may *create* a security issue, and it cannot solve one.
>>>>>
>>>>> I can see you are frustrated with my initial take on this, but please
>>>>> understand that excluding an operation from the security policy is not
>>>>> something to take lightly and needs discussion.  I've added the
>>>>> SELinux refpolicy list to this thread as I believe their input would
>>>>> be helpful here.
>>>>
>>>> Absolutely it is not something that should be taken lightly, though I
>>>> strongly believe it is correct in this case.  Is one of my assumptions
>>>> mistaken?
>>>
>>> My concern is that there is a distro/admin somewhere which is relying
>>> on their SELinux policy enforcing access controls on these ioctls and
>>> removing these controls would cause them a regression.
>>
>> I obviously do not have visibility into all systems, but I suspect that
>> nobody is actually relying on this.  Setting and clearing CLOEXEC via
>> fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
>> blocked by seccomp or another LSM.  Clearing close-on-exec can also be
>> implemented with dup2(), and setting it can be implemented with dup3()
>> and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe
>> that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world
>> problems, and that it is highly unlikely that anyone is relying on the
>> current behavior.
> 
> I understand your point, but I remain concerned about making a kernel
> change for something that can be addressed via policy.  I'm also
> concerned that in the nine days this thread has been on both the mail
> SELinux developers and refpolicy lists no one other than you and I
> have commented on this patch.  In order to consider this patch
> further, I'm going to need to see comments from others, preferably
> those with a background in supporting SELinux policy.
> 
> Also, while I'm sure you are already well aware of this, I think it is
> worth mentioning that SELinux does apply access controls when file
> descriptors are inherited across an exec() boundary.


I don't have a strong opinion either way.  If one were to allow this 
using a policy rule, it would result in a major policy breakage.  The 
rule would turn on extended perm checks across the entire system, which 
the SELinux Reference Policy isn't written for.  I can't speak to the 
Android policy, but I would imagine it would be the similar problem 
there too.


--
Chris PeBenito
