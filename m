Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391574BBAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiBROuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:50:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiBROuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:50:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDED5FF08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:50:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CB971F37F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645195836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZjjuCWzDGsPjtSI2F/vV42BCKspds8Wbx2Wj8LtwCg=;
        b=meA4QEuY2Jl0YSg2unL1N4rcGJN7feLyOfwBR/PozXcEdQEInUuObd6BguaFVPXRXticLa
        x9jSdnj6Ct1TtyATdpl/hJm9FhstVQt2WTFvCv7OO9vjnKGjtwBTwdFIEoBoE10nG0pSQl
        oDOf9oyicpSq97UnnQjf2gtiO71CqAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645195836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZjjuCWzDGsPjtSI2F/vV42BCKspds8Wbx2Wj8LtwCg=;
        b=Q6hssRHzVKzOJcJdO9DxK3vUQT6+fZEaQQOwCTKa7XetFUEpBbqYo/gYcUT5J5iYlCRxVc
        6QlWC/N9uRDpbpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20C3913C95
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lkHFBTyyD2J+EQAAMHmgww
        (envelope-from <sbrabec@suse.cz>)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:50:36 +0000
Message-ID: <8a80986c-6563-02c8-7a4b-d798527f9b3a@suse.cz>
Date:   Fri, 18 Feb 2022 15:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [RFC] uuid_generate_time_safe() without uuidd should always return -1
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a deeper research, we realized that only the uuidd provides the 
guarantee of uniqueness of UUIDs across different CPUs and different UIDs.

Without it, there is a probability that two different processes on two 
different CPUs with a different UID will call uuid_generate_time_safe() 
in the same time and generate duplicated UUIDs.

There is a LIBUUID_CLOCK_FILE that should prevent it. But this approach 
can work properly for a single UID only. And creating it world-writable 
file would cause more problems that it will fix.

That is why I propose that uuid_generate_time_safe() should always 
return -1 in case that it cannot interact with uuidd.

To realize this, uuid_generate_time_generic() should return -1 instead 
of __uuid_generate_time() return code.

It should not break uuidd, as it calls __uuid_generate_time() directly.


In the last month, we had a discussion about one clock file per UID and 
one for uuidd as a solution of LIBUUID_CLOCK_FILE being handled in a 
first-UID-wins manner. It could improve the situation, but only for 
UUIDs generated by the same UID.

Both changes are partially mutually exclusive: If 
uuid_generate_time_safe() will always return -1, there will be no chance 
to inform the program, that the alternative synchronization was used. 
(This information could still be useful.) That it why I propose a small 
change of API:

Add a new return code of uuid_generate_time_safe().

== RETURN VALUE

The newly created UUID is returned in the memory location pointed to by 
_out_. *uuid_generate_time_safe*() returns zero if the UUID has been 
generated in a safe manner, 1 if the UUID has been generated in a manner 
that is safe for a single UID, -1 otherwise.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

