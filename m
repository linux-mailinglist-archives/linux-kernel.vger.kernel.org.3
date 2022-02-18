Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD94BBC83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiBRPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:52:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBRPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:52:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F5E575D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:52:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB3D219A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645199551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ei1Vd5fNZFUOCZCZwob+6kHe68Sb0cwp52ZkiPkvkns=;
        b=PEIwj4bT0afBR5K3FUQKxapPVdHrc80HCjpgkdqsXO65RViXzz7BJILSllaoHdNODCBi08
        wEm+fbAGJqeNqqFBRA2wj87PmNzGy+MZIR7GFTUWo1YN3C1RTlAihSFGl8L/A3rNA9EmuH
        UqH+ZT23kYAg4U1aZe8Fn6ixPTV8v2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645199551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ei1Vd5fNZFUOCZCZwob+6kHe68Sb0cwp52ZkiPkvkns=;
        b=LshLo4mrVXEKfumK3eeMYT4ZhXwo2vFrG4183rMgdYTcVlENsT85PIy/F9QvPH2i2rD0AW
        bX1LSD1aJ8eKOVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1924E13C9B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jP5IBL/AD2JPLwAAMHmgww
        (envelope-from <sbrabec@suse.cz>)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:52:31 +0000
Message-ID: <994bb806-a72d-0e85-b240-92f3c7dc3e09@suse.cz>
Date:   Fri, 18 Feb 2022 16:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] uuid_generate_time_safe() without uuidd should always
 return -1
Content-Language: en-US
From:   Stanislav Brabec <sbrabec@suse.cz>
To:     linux-kernel@vger.kernel.org
References: <8a80986c-6563-02c8-7a4b-d798527f9b3a@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <8a80986c-6563-02c8-7a4b-d798527f9b3a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Brabec wrote:
> After a deeper research, we realized that only the uuidd provides the 
> guarantee of uniqueness of UUIDs across different CPUs and different UIDs.
Sorry, bad list.

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

