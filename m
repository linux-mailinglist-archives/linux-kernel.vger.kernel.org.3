Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C74EEC09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiDALLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDALLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:11:09 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 04:09:20 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06126ECA3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:09:19 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri,  1 Apr 2022 13:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1648811358; bh=sFx/9K+fATOwENpzWD0YB1nZDFiZRSMkfrxRTxYpYu4=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=f1+caPrFTM9krPvMzGaMjvf21458ykaBZj+qyEm215jn1ETA64nFCVVgl9ybWQsmn
         eTo3J6miq1wsVvuBB5chBT3SOZawGquvDTWqYQ9Qk2xF2RHhlMLe2tof8vqxumssfJ
         f557qT00kleC6jIOvQoCyiQqddX7WpoIPB8WkmSE=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 553F581C33;
        Fri,  1 Apr 2022 13:09:17 +0200 (CEST)
Received: from buildd.core.avm.de ([172.16.0.225])
          by mail-notes.avm.de (HCL Domino Release 12.0.1HF50)
          with ESMTP id 2022040113024702-22341 ;
          Fri, 1 Apr 2022 13:02:47 +0200
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 0378D180FAB; Fri,  1 Apr 2022 13:02:46 +0200 (CEST)
Date:   Fri, 01 Apr 2022 13:02:46 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        David Heidelberg <david@ixit.cz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: decompressor: fix unneeded rebuilds of library
 objects
Message-ID: <Ykbb1ow2Oya0aXb+@buildd.core.avm.de>
References: <20220331084709.1079362-1-masahiroy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220331084709.1079362-1-masahiroy@kernel.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 12.0.1HF50 | March 1,
 2022) at
 01.04.2022 13:02:47,
        Serialize by http on ANIS1/AVM(Release 12.0.1HF50 | March 1, 2022) at
 01.04.2022 13:04:32,
        Serialize complete at 01.04.2022 13:04:32
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Old-Date: Fri, 1 Apr 2022 13:02:46 +0200
X-Notes-UNID: 39A4C571028BCD46B1950F2992BC67A7
X-purgate-ID: 149429::1648811358-0000050B-38C9F536/0/0
X-purgate-type: clean
X-purgate-size: 721
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:47:09PM +0900, Masahiro Yamada wrote:
> Since commit 251cc826be7d ("ARM: 9154/1: decompressor: do not copy source
> files while building"), the following three are rebuilt every time.
> 
>   AS      arch/arm/boot/compressed/lib1funcs.o
>   AS      arch/arm/boot/compressed/ashldi3.o
>   AS      arch/arm/boot/compressed/bswapsdi2.o
> 
> Move the "OBJS += ..." line up so these objects are added to 'targets'.
> 
> Fixes: 251cc826be7d ("ARM: 9154/1: decompressor: do not copy source files while building")
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Tested-by: Nicolas Schier <n.schier@avm.de>
