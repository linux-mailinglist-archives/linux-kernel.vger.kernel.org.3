Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2064E95BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiC1LxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbiC1Ltv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:49:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390F15A2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:44:06 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nYnn2-0001nr-F8; Mon, 28 Mar 2022 13:44:04 +0200
Message-ID: <45051cd2-2e28-3065-776b-d5e83c998cb5@leemhuis.info>
Date:   Mon, 28 Mar 2022 13:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 215711 - snd_hda_intel not binding to codec
Cc:     Petr Cerny <bugzilla@black-net.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648467846;ae059630;
X-HE-SMSGID: 1nYnn2-0001nr-F8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org that afaics nobody
acted upon since it was reported about a week ago, that's why I decided
to forward it to the lists and the maintainers. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=215711:

> Created attachment 300588 [details]
> SND_HDA_* excrept from kernel config
> 
> On PCI device discovery the Intel HDA codec doesn't bind to appropriate codec (if that is the correct term). The device codec (Conexant) is loaded, but sound doesn't work. Reloading the main module (snd_hda_intel) fixes the issue:
> 
> $ echo 1 > /sys/bus/pci/devices/0000:00:1b.0/remove
> 
> $ lsmod | sort
> Module                  Size  Used by
> configs                45056  0
> e1000e                225280  0
> grace                  16384  1 lockd
> irqbypass              16384  1 kvm
> iwlwifi               274432  0
> kvm                   569344  1 kvm_intel
> kvm_intel             229376  0
> lockd                  98304  1 nfs
> mei                    90112  1 mei_me
> mei_me                 28672  0
> nfs                   184320  3 nfsv4
> nfsv4                 380928  2
> sunrpc                274432  9 nfsv4,lockd,nfs
> uvcvideo              110592  0
> videobuf2_common       45056  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
> videobuf2_memops       16384  1 videobuf2_vmalloc
> videobuf2_v4l2         24576  1 uvcvideo
> videobuf2_vmalloc      16384  1 uvcvideo
> 
> $ echo 1 > /sys/bus/pci/rescan
> # dmesg output
> [ 9218.563134] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
> [ 9218.563178] pci 0000:00:1b.0: reg 0x10: [mem 0xc0004000-0xc0007fff 64bit]
> [ 9218.563344] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [ 9218.563818] pci 0000:00:1b.0: BAR 0: assigned [mem 0xc0004000-0xc0007fff 64bit]
> [ 9218.563846] pci 0000:00:1e.0: PCI bridge to [bus 0e]
> [ 9218.598927] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 0xffffffff824a44e0)
> [ 9218.609798] snd_hda_intel 0000:00:1b.0: Cannot probe codecs, giving up
> 
> $ lsmod | sort
> Module                  Size  Used by                                                                                                                                                                                                                                            
> configs                45056  0                                                                                                                                                                                                                                                  
> e1000e                225280  0                                                                                                                                                                                                                                                  
> grace                  16384  1 lockd                                                                                                                                                                                                                                            
> irqbypass              16384  1 kvm                                                                                                                                                                                                                                              
> iwlwifi               274432  0                                                                                                                                                                                                                                                  
> kvm                   569344  1 kvm_intel                                                                                               
> kvm_intel             229376  0                                                                                                         
> lockd                  98304  1 nfs                                                                                                     
> mei                    90112  1 mei_me                                                                                                  
> mei_me                 28672  0                                                                                                         
> nfs                   184320  3 nfsv4                                                                                                   
> nfsv4                 380928  2                                                                                                         
> snd                    77824  7 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_timer,snd_pcm    
> snd_hda_codec         118784  3 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hda_intel                                              
> snd_hda_codec_conexant    20480  0                                                                                                      
> snd_hda_codec_generic    77824  1 snd_hda_codec_conexant                                                                                
> snd_hda_core           65536  4 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hda_intel,snd_hda_codec                                
> snd_hda_intel          36864  0                                                                                                         
> snd_hwdep              16384  1 snd_hda_codec                                                                                           
> snd_intel_dspcfg       16384  1 snd_hda_intel                                                                                           
> snd_pcm               110592  3 snd_hda_intel,snd_hda_codec,snd_hda_core                                                                
> snd_timer              32768  1 snd_pcm                                                                                                 
> soundcore              16384  1 snd                                                                                                     
> sunrpc                274432  9 nfsv4,lockd,nfs                                                                                         
> uvcvideo              110592  0                                                                                                         
> videobuf2_common       45056  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
> videobuf2_memops       16384  1 videobuf2_vmalloc
> videobuf2_v4l2         24576  1 uvcvideo
> videobuf2_vmalloc      16384  1 uvcvideo
> 
> $ modprobe -rv snd_hda_intel; modprobe -v snd_hda_intel
> # dmesg output
> [ 9230.886362] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 0xffffffff824a44e0)
> [ 9230.895721] snd_hda_codec_conexant hdaudioC0D0: CX20585: BIOS auto-probing.
> [ 9230.896677] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20585: line_outs=1 (0x1f/0x0/0x0/0x0/0x0) type:speaker
> [ 9230.896691] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 9230.896700] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=2 (0x1c/0x19/0x0/0x0/0x0)
> [ 9230.896707] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
> [ 9230.896713] snd_hda_codec_conexant hdaudioC0D0:    inputs:
> [ 9230.896718] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x23
> [ 9230.896724] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x1b
> [ 9230.896729] snd_hda_codec_conexant hdaudioC0D0:      Dock Mic=0x1a
> [ 9230.908437] snd_hda_codec_generic hdaudioC0D3: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
> [ 9230.908454] snd_hda_codec_generic hdaudioC0D3:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 9230.908461] snd_hda_codec_generic hdaudioC0D3:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 9230.908468] snd_hda_codec_generic hdaudioC0D3:    mono: mono_out=0x0
> [ 9230.908473] snd_hda_codec_generic hdaudioC0D3:    dig-out=0x5/0x0
> [ 9230.908477] snd_hda_codec_generic hdaudioC0D3:    inputs:
> [ 9230.916063] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input52
> [ 9230.916216] input: HDA Intel MID Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input53
> [ 9230.916353] input: HDA Intel MID Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input54
> [ 9230.919563] input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input55
> [ 9230.919727] input: HDA Intel MID HDMI as /devices/pci0000:00/0000:00:1b.0/sound/card0/input56
> 
> $ lsmod | sort
> Module                  Size  Used by
> configs                45056  0
> e1000e                225280  0
> grace                  16384  1 lockd
> irqbypass              16384  1 kvm
> iwlwifi               274432  0
> kvm                   569344  1 kvm_intel
> kvm_intel             229376  0
> lockd                  98304  1 nfs
> mei                    90112  1 mei_me
> mei_me                 28672  0
> nfs                   184320  3 nfsv4
> nfsv4                 380928  2
> snd                    77824  7 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_timer,snd_pcm
> snd_hda_codec         118784  3 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hda_intel
> snd_hda_codec_conexant    20480  1
> snd_hda_codec_generic    77824  2 snd_hda_codec_conexant
> snd_hda_core           65536  4 snd_hda_codec_generic,snd_hda_codec_conexant,snd_hda_intel,snd_hda_codec
> snd_hda_intel          36864  0
> snd_hwdep              16384  1 snd_hda_codec
> snd_intel_dspcfg       16384  1 snd_hda_intel
> snd_pcm               110592  3 snd_hda_intel,snd_hda_codec,snd_hda_core
> snd_timer              32768  1 snd_pcm
> soundcore              16384  1 snd
> sunrpc                274432  9 nfsv4,lockd,nfs
> uvcvideo              110592  0
> videobuf2_common       45056  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
> videobuf2_memops       16384  1 videobuf2_vmalloc
> videobuf2_v4l2         24576  1 uvcvideo
> videobuf2_vmalloc      16384  1 uvcvideo
> 
> 
> 5.15.29, have observed it already at least on 5.10.27, HW is ThinkPad x201 (x220 as well). I'm marking it as regression, since it used to work in the distant past (5.4-ish at least iirc)

Could somebody take a look into this? Or was this discussed somewhere
else already? Or even fixed?

Anyway, to get this tracked:

#regzbot introduced: v5.4..v5.10
#regzbot from: Petr Cerny <bugzilla@black-net.org>
#regzbot title: snd: snd_hda_intel not binding to codec
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215711

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

