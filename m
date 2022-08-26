Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E305A2610
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbiHZKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:46:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8B3FA04;
        Fri, 26 Aug 2022 03:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B663E1FDA9;
        Fri, 26 Aug 2022 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661510764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa/3ypYSJSQW433oi1w/2O4+8Mbdi8Blp1YdWljoRSg=;
        b=rEmlke3oS5xgtWurko+VQbWOg814W/WaYopKvn6LehJnfbW1bMJQb5ur1/cVEQX3+KDwnz
        Gn1H//eh+uuco2IKLZZdgmclsuQcjxMtuXfJek/bwGn4Qo5PsGpZjkdjfPUfWc46xQAnVY
        WmZ670H63mvj+djY3YHiXM4D6KGCCEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661510764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa/3ypYSJSQW433oi1w/2O4+8Mbdi8Blp1YdWljoRSg=;
        b=tHGd5UQXO8TmzcCocfN/smLfbn4Z7fne2gDb+sUqnSK8WJWYedige4XOnK4eNNotFVfhx/
        kLxQe2exohFupjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F09413A7E;
        Fri, 26 Aug 2022 10:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X2U2HWykCGNhYwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 26 Aug 2022 10:46:04 +0000
Date:   Fri, 26 Aug 2022 12:46:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
Message-ID: <20220826124603.4a28a154@endymion.delvare>
In-Reply-To: <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
References: <20220825144012.24a33bb0@endymion.delvare>
        <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, 25 Aug 2022 23:12:43 +0300, Andy Shevchenko wrote:
> On Thu, Aug 25, 2022 at 3:54 PM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > When CONFIG_OF isn't set, we can optimize out dmard06_of_match as it
> > will never be used.  
> 
> NACK. There is a magic PRP0001 for ACPI case.

OK, I wasn't aware of this. As of_match_device() is a stub when
CONFIG_OF isn't set, I thought the table could never be used. But now I
see that the acpi subsystem accesses the table directly, so you are
correct, the optimization I suggested is bogus.

Now I'm curious, is there a well-defined subset of device names that
can be found in an ACPI table? If not, does that mean that any driver
with an OF entry could match, therefore of_match_ptr() should be
removed from the kernel entirely?

Another possibility would be to stub out of_match_ptr() only if neither
CONFIG_OF nor CONFIG_ACPI is set. But I'm not sure that would be worth,
as I expected either to be set on almost all kernels in practice
(except on s390x, but you wouldn't build any of these drivers there
anyway).

-- 
Jean Delvare
SUSE L3 Support
