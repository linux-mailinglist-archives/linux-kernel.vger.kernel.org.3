Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33F749FAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbiA1Nax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiA1Nax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:30:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3CC06173B;
        Fri, 28 Jan 2022 05:30:52 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nDRL1-0001Kw-GW; Fri, 28 Jan 2022 14:30:51 +0100
Message-ID: <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info>
Date:   Fri, 28 Jan 2022 14:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
Content-Language: en-BS
To:     Davyd McColl <davydm@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643376653;7a44b2a1;
X-HE-SMSGID: 1nDRL1-0001Kw-GW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

Davyd, Ronnie, and/or Steve: What the status here? It seems after some
productive debugging back and forth it seems everyone forgot about this.
Or was progress made somewhere and I just missed it?

Ciao, Thorsten

#regzbot poke


On 12.01.22 06:49, Davyd McColl wrote:
> Hi Ronnie
> 
> The regular fstab line for this mount is:
> 
> //mede8er/mede8er  /mnt/mede8er-smb  cifs
> noauto,guest,users,uid=daf,gid=daf,iocharset=utf8,vers=1.0,nobrl,sec=none
>  0  0
> 
> Altering the end of the options from "sec=none" to
> "username=guest,sec=ntlmssp" or "guest,sec=ntlmssp" results in failure
> to mount
> (tested on my patched kernel, which still supports the original fstab
> line), with dmesg containing:
> 
> [45753.525219] CIFS: VFS: Use of the less secure dialect vers=1.0 is
> not recommended unless required for acc
> ess to very old servers
> [45753.525222] CIFS: Attempting to mount \\mede8er\mede8er
> [45756.861351] CIFS: VFS: Unable to select appropriate authentication method!
> [45756.861361] CIFS: VFS: \\mede8er Send error in SessSetup = -22
> [45756.861395] CIFS: VFS: cifs_mount failed w/return code = -22
> 
> There is no way that I know of to set up users for smb auth on this
> device - it only supports guest connections.
> 
> -d
> 
> 
> On Wed, 12 Jan 2022 at 04:32, ronnie sahlberg <ronniesahlberg@gmail.com> wrote:
>>
>> Thanks for the network traces.
>>
>> In the traces, both win11 and linux are not using even NTLM but the
>> even older "share password" authentication mode where you specify a
>> password for the share in the TreeConnect command.
>> That is something I think we should not support at all.
>>
>> What is the exact mount command line you use?
>> Can you try mounting the share using a username and ntlmssp ?
>> I.e. username=your-user,sec=ntlmssp  on the mount command
>>
>> regards
>> ronnie sahlberg
>>
>> On Wed, Jan 12, 2022 at 6:57 AM Davyd McColl <davydm@gmail.com> wrote:
>>>
>>> Hi Steve
>>>
>>> As requested, wireshark captures to the device in question, as well as
>>> the fstab entry I have for the device:
>>> - win11, browsing with explorer
>>> - win11, net use
>>> - unpatched linux 5.16.0 attempt to mount
>>> - patched linux 5.16.0 successful mount
>>> - fstab entry - note that I have to specify samba version 1.0 as the
>>> default has changed and the mount fails otherwise. Explicitly
>>> specifying 2.0 errors and suggests that I should select a different
>>> version.
>>>
>>> -d
>>>
>>> On Tue, 11 Jan 2022 at 00:13, Steve French <smfrench@gmail.com> wrote:
>>>>
>>>> I would be surprised if Windows 11 still negotiates (with default
>>>> registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
>>>> Windows 11 with an NTLMv1 only server (they are hard to find - I may
>>>> have an original NT4 and an NT3.5 CD somewhere - might be possible to
>>>> install a VM with NT3.5 but that is really really old and not sure I
>>>> can find those CDs).
>>>>
>>>> Is it possible to send me the wireshark trace (or other network trace)
>>>> of the failing mount from Linux and also the one with the succeeding
>>>> NET USE from Windows 11 to the same server?
>>>>
>>>> Hopefully it is something unrelated to NTLMv1, there has been a LOT of
>>>> pushback across the world, across products in making sure no one uses
>>>> SMB1 anymore.  See e.g.
>>>> https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
>>>> and https://twitter.com/nerdpyle/status/776900804712148993
>>>>
>>>> On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
>>>>>
>>>>> I don't understand. I tracked down the exact commit where the issue
>>>>> occurs with a 2 hour git bisect. This was after first confirming that
>>>>> my older 5.14 kernel did not display the symptoms. I can still connect
>>>>> to the share via windows 11 explorer. I don't know what else I need to
>>>>> do here to show where the issue was introduced?
>>>>>
>>>>> Apologies for bouncing mails - literally no email client I have seems
>>>>> to be capable of plaintext emails, so every time I forget, I have to
>>>>> find a browser with the gmail web interface to reply.
>>>>>
>>>>> -d
>>>>>
>>>>> On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
>>>>>>
>>>>>> I want to make sure that we don't have an unrelated regression
>>>>>> involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
>>>>>> this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
>>>>>> supported in Windows 2000")  and should be the default for Windows
>>>>>> NT4, Windows 2000 etc. as well as any version of Samba from the last
>>>>>> 15 years+.  I have significant concerns with adding mechanisms that
>>>>>> were asked to be disabled ~19 years ago e.g. see
>>>>>> https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
>>>>>> due to security concerns.
>>>>>>
>>>>>> Can we double check that there are not other issues involved in your example?
>>>>>>
>>>>>> The concerns about NTLMv1 security concerns (and why it should never
>>>>>> be used) are very persuasive e.g. many articles like
>>>>>> https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
>>>>>>
>>>>>> On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
>>>>>>>
>>>>>>> Good day
>>>>>>>
>>>>>>> I'm following advice from the thread at
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
>>>>>>> this, so please bear with me and redirect me as necessary.
>>>>>>>
>>>>>>> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
>>>>>>> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
>>>>>>> runs some older linux). Apparently I'm not the only one, according to
>>>>>>> that thread, though the other affected party there is windows-based.
>>>>>>>
>>>>>>> I first logged this in the Gentoo bugtracker
>>>>>>> (https://bugs.gentoo.org/821895) and a reversion patch is available
>>>>>>> there for the time being.
>>>>>>>
>>>>>>> I understand that some of the encryption methods upon which the
>>>>>>> original feature relied are to be removed and, as such, the ability to
>>>>>>> mount these older shares was removed. This is sure to affect anyone
>>>>>>> running older Windows virtual machines (or older, internally-visible
>>>>>>> windows hosts) in addition to anyone attempting to connect to shares
>>>>>>> from esoteric devices like mine.
>>>>>>>
>>>>>>> Whilst I understand the desire to clean up code and remove dead
>>>>>>> branches, I'd really appreciate it if this particular feature remains
>>>>>>> available either by kernel configuration (which suits me fine, but is
>>>>>>> likely to be a hassle for anyone running a binary distribution) or via
>>>>>>> boot parameters. In the mean-time, I'm updating my own sync software
>>>>>>> to support this older device because if I can't sync media to the
>>>>>>> player, the device is not very useful to me.
>>>>>>>
>>>>>>> Thanks
>>>>>>> -d
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Thanks,
>>>>>>
>>>>>> Steve
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>>>>> If you say that getting the money is the most important thing
>>>>> You will spend your life completely wasting your time
>>>>> You will be doing things you don't like doing
>>>>> In order to go on living
>>>>> That is, to go on doing things you don't like doing
>>>>>
>>>>> Which is stupid.
>>>>>
>>>>> - Alan Watts
>>>>> https://www.youtube.com/watch?v=-gXTZM_uPMY
>>>>>
>>>>> Quidquid latine dictum sit, altum sonatur.
>>>>
>>>>
>>>>
>>>> --
>>>> Thanks,
>>>>
>>>> Steve
>>>
>>>
>>>
>>> --
>>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>>> If you say that getting the money is the most important thing
>>> You will spend your life completely wasting your time
>>> You will be doing things you don't like doing
>>> In order to go on living
>>> That is, to go on doing things you don't like doing
>>>
>>> Which is stupid.
>>>
>>> - Alan Watts
>>> https://www.youtube.com/watch?v=-gXTZM_uPMY
>>>
>>> Quidquid latine dictum sit, altum sonatur.
> 
> 
> 

