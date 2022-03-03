Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFC4CBB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCCKS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiCCKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:18:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B6F43EEF;
        Thu,  3 Mar 2022 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646302675;
        bh=yNu5aV72kAVxWE9AEOpRwhvXEvz9REi7V2L5i8b9h3s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jqnKQY8QLOza54CSQbVUOmiQNlvoH/SQ3tAXO3JCVh1otqSL05CaQe7NMWApUEI2P
         PouLUKOwI8kjcNnVO98rScBjHK1x7721Iu+pmTOX+yUMA4n9YhOE2vNPXgYDeqCDLp
         ZzC/aUE9MkCTBwO9KVvb9oE7Q9eQYs3lwXUHPFeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.242.61] ([80.187.120.72]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1o4WrG29AL-00f7DI; Thu, 03
 Mar 2022 11:17:55 +0100
Message-ID: <3c08fd49-75e6-7016-a686-06a761cc679a@gmx.de>
Date:   Thu, 3 Mar 2022 11:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] video: fbdev: sm712fb: Fix crash in smtcfb_write()
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220302143311.2109322-1-zheyuma97@gmail.com>
 <666d1565-0467-bb21-916b-073392129e1a@gmx.de>
 <CAMhUBj=P82_f6LdhWqEbe06SRPrMU2jxquNzgWkrttGDy6C4Kg@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMhUBj=P82_f6LdhWqEbe06SRPrMU2jxquNzgWkrttGDy6C4Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sAuAfXYVTz6VzBrsH0AZ6HYOL+QvuzH6C6VJQMmPCQOOf7g6N8V
 8fkZrdNxVTACopONE1EiqqXi4q0t4n1GveqG93hk6YSmhwZirDXLAarWnen/abTWi9qfYI4
 zlTaMeHpviWUsI+OYubD/B5rTs/Co0x1YEwJAM4ZLzsBf5WtKMa614rthfCexDC5wVtPFFD
 vNfnoyjY+0Kl52myht5Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Z+A3Af0e4Y=:BO1NxRaM9pV41v0I9lTPln
 JOPxRf0O6EL7ElB7OoTlW4bET6INglJZiTidgeVP4thMMeirpfSdHoZ26DbSVer8qq06OtfVy
 RtL5IEdtAzS0RSkne6SNYm4UJyG2eX1X0Qu2YPFQN6Btf5+qRbz1UVGqM+GQimVtajaubMA2Z
 CVKje8ENX2nbbSkBCUn1gmae2dczvB2+t+qukd2v7E692w1M1N1dAvvmevXmaOlcJ1aeImnTT
 ECP71SL2grzMFGdgmwVwNEkLHAFVDDCCGCbAulPxK3KCAdjW0uOjAfVOvZ+zXXCnEWLcVktzQ
 Q7zVQuvTSpKSatdt1ejgwKmgDYA08C9qLLujmTVssxpY86Vn063vR7BGvvYfKcQzEKPAH4bR8
 xmdGGREub7/VhIzGXKxtfmuk6+Q/gqBdnadu8vwdp0hoSYkdoaaLIr8PKtCQ/PwBh6D4yVoPu
 cwAATba8u9ftOc6hucQ5/byfC7GeEnmhsMa+7MKHVghFrPE/SrxlwkqdsKWojIhjJd5O/idty
 7yBPegqYvQyqzDMJxe+1x63CDYjQgRekl3yZ7FBMockfZyHHgKF5MBI3iA+MfJ+6os1k2wt1T
 JVFgNS4jVTPW0DNy6t2I20xp3dNf7NDL5peHr3xRt7OX4+EwuJ+iH83EDauBemxlhPs2ol2ID
 +EIm5Z/ahVx1+6u1qCrzhIcHqnWPEbMyFJ2cyancsOz11AMUAsUWOK/kb6+4VEdrrxgrW0wwl
 f4un8VCMenf34zIIZVhmiC2pvgr+H8j6/74lC2SX5zuqXAAQN0UT56WjnUolbry8nXwovOQNZ
 cCrhP0DuK3A57wKiaXrcHcjT1ill94A8qM3ClJ9K+xBlFAEteFN1tcM3n4/KH7w2fZ5Nb5O3c
 +h+sJy/t+VUTWaKtG2YPi7/Wv173MBfBUs5KK9IH1JvDaUungVe4sKfZzxkFO9a9uqHrW8Wbb
 L/Wq4H8/oDLIx4CpGcJAoJMJgdp2uwR3Bc/maPw2Yq3Y5B98GhfDYd+72smv4q/Ssd1r+SGiZ
 4P90OY6QTe8cQrChV5L7nRLjNoqv8OB8eFmIRFCtsMut2VWrKkbW7c2PcbieTuAHakiZxhBxZ
 P8JUPgbpvREqPY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 02:34, Zheyu Ma wrote:
> Hi,
>
> On Thu, Mar 3, 2022 at 12:49 AM Helge Deller <deller@gmx.de> wrote:
>>
>> On 3/2/22 15:33, Zheyu Ma wrote:
>>> When the sm712fb driver writes three bytes to the framebuffer, the
>>> driver will crash:
>>>
>>>     BUG: unable to handle page fault for address: ffffc90001ffffff
>>>     RIP: 0010:smtcfb_write+0x454/0x5b0
>>>     Call Trace:
>>>      vfs_write+0x291/0xd60
>>>      ? do_sys_openat2+0x27d/0x350
>>>      ? __fget_light+0x54/0x340
>>>      ksys_write+0xce/0x190
>>>      do_syscall_64+0x43/0x90
>>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> Fix it by removing the open-coded endianness fixup-code.
>>>
>>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>>
>> Thanks... it's already in the fbdev git tree and queued up for v5.18...
>> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/=
commit/?h=3Dfor-next&id=3Dbd771cf5c4254511cc4abb88f3dab3bd58bdf8e8
>
> This patch fixes the crash in smtcfb_read(), but there is a similar
> bug in smtcfb_write(), and I mocked up your patch a wrote a new patch
> for it.
> So we should fix two bugs with two patches.

Right, I missed the read() code.

I applied your patch now to the fbdev for-next git tree.

Thanks!
Helge


>
> Regards,
> Zheyu Ma

