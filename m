Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7F51CE87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388272AbiEFCHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiEFCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:07:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172856350B;
        Thu,  5 May 2022 19:03:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j4so10311225lfh.8;
        Thu, 05 May 2022 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKYi26TVId4XJ3rsFQFXxxa0VYH2bEQs/T3TVCsZyWY=;
        b=Ec7uqiRrmNflD7XqE8xKtpAd0dVTt4z2hC/Q/3cghEDYu9nQ4WBbIvclw4XhXP0I+9
         JSwNtdxvcAv1pw0Jxq14r+m6b9aV3t/eqB7TQKvUDXZ7LlpInSqdKfD6021JRpDfCgDf
         AQGGhJW3W7krV/IYrcJjKCKAppOIxPot5Gu+mb47sonPFRHsiN4o6RPoSxFFaLq1c929
         C1w6cG1OKjerJIPtIGwvIHE4K1owOAvfS5PROutCiy6LVMwjPdIOVTpRrrNad0EneWuD
         jrvWnvZq4fbBKRLTFACvdrlnAOBIwK9RFF3O4cKq3dUrToKBsCkk7IWNbMo8KS0wIfh2
         TTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKYi26TVId4XJ3rsFQFXxxa0VYH2bEQs/T3TVCsZyWY=;
        b=IuWCopFf/Z+muKyIVeqdqACmWB33+vDcTpJ1/kjKk0s+SjdtKYtqYHvZLIbp6yIJZz
         4cX2A1TzCmNVbDKaogS75fmS1pXoUzRZtC9QHrIGHFaVx5pwZA0R8dPVXAf4O1wp7+AE
         qUrTt1/mKDomkE7YVxisSQyW72mbjWiIdylA2xPF63N+MjYqO+6vXnMOpX/XmUa+G9Wp
         kwzHnFwGJN1pNQZKlN8pT4G1CzsSrl45T1uv7wHErcYXLbnhtlQqDXCtVXxPeksBia+1
         81pFu/VFgmzDIoKiKfgHaEX1VStTIrOawJWiz7KZdfdPi8G3kDjxcc60n2VkA7NZO71Y
         dEsw==
X-Gm-Message-State: AOAM533qi2O0RWpzJQzf4F8xVCVauXo8m16+YYW7OKLhcNZGhM3daRIC
        Kzwokrb5I5Hm3dm91I27oxTkfD38lNLq2FPRLA4OwLfA
X-Google-Smtp-Source: ABdhPJwjcMAWpkvBThGpXT7YvOw+TK0nsJdmb/BHZdjmLt7kzH/aqY2LEkptClKfUTR54oxy5V0+/uZO+AFcT7Ns8T8=
X-Received: by 2002:ac2:484c:0:b0:472:357:f8fb with SMTP id
 12-20020ac2484c000000b004720357f8fbmr860295lfy.601.1651802631156; Thu, 05 May
 2022 19:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz> <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
 <87tua51550.fsf@cjr.nz> <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com> <87r15910c1.fsf@cjr.nz>
In-Reply-To: <87r15910c1.fsf@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 5 May 2022 21:03:40 -0500
Message-ID: <CAH2r5muEMNZ8opMrkR4O5Od3W7oYmSgi9-ytQJqegF=XVJ757w@mail.gmail.com>
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too long
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Tom Talpey <tom@talpey.com>, Byron Stanoszek <gandalf@winds.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes - this makes sense.  Patch would be appreciated (just got back
from LSF/MM, so catching up after travel)

On Thu, May 5, 2022 at 8:59 PM Paulo Alcantara <pc@cjr.nz> wrote:
>
> Tom Talpey <tom@talpey.com> writes:
>
> > I think the most conservative and spec-compliant choice should be made.
> > SMB1 should not be pushing the envelope of interoperability, in this day
> > and age.
>
> OK.
>
> > I believe the NetBIOS name is a fixed array of 16 octets, right? So, if
> > the nodename is shorter, it needs to be padded with 0's.
>
> Right.
>
> > Did this code change recently? Why???
>
> We used to not send the WorkstationName during NTLMSSP until recent
> patch from Shyam:
>
>         commit 49bd49f983b5026e4557d31c5d737d9657c4113e
>         Author: Shyam Prasad N <sprasad@microsoft.com>
>         Date:   Fri Nov 5 19:03:57 2021 +0000
>
>             cifs: send workstation name during ntlmssp session setup
>
>             During the ntlmssp session setup (authenticate phases)
>             send the client workstation info. This can make debugging easier on
>             servers.
>
>             Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
>             Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
>             Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
>             Signed-off-by: Steve French <stfrench@microsoft.com>
>
> Unfortunately some servers did not seem to enforce it to be 16 bytes
> long, so the reason why we didn't catch it earlier.
>
> Steve, Shyam, let me know if it does make sense to you and then I can
> work on a patch to fix it properly.



-- 
Thanks,

Steve
