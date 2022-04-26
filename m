Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2357E51035A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbiDZQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiDZQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:34:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3A3157DCE;
        Tue, 26 Apr 2022 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=puEHxiHmekhBokZkfX+PosZYQtXEk03Xp8eQva9Bj+8=; b=rpiKOOQCl+wMo2ZBJybeim/aQ8
        G1VVuExU8TbuASs4MvNBUwmEdSLk7CyKeYXO87gI/dpVXnNlnd7Y1cbBvBncRr1Y5cx4MLs6xyozY
        LZMaSZrC0Nv2UOoGmtyOjkSpqHQm8sZm8dPr3re9/byEZCQ8EjNc7KB+RlTSPlLn2qv2hAr8fwyV1
        OG5rj4Kfo8vNDq8+Id4xcXeR8/ZMbUA2RAh5oWnSUiq9kbtMCMSedGJm37lfjpozOBe+QAacSL4+8
        xH3bwTp6k+KFgbZZz/OkWRRo3cmV/I6CklqAQrNSUeT8++K+/eCrcuTWoByq+5ImtCef28FjkDHRz
        xZljr48g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njO5h-00FLzL-IP; Tue, 26 Apr 2022 16:31:05 +0000
Date:   Tue, 26 Apr 2022 09:31:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmgeSXJ9qWUI3J8/@bombadil.infradead.org>
References: <20220422013215.2301793-1-tweek@google.com>
 <YmK9lhEENKFnr6sd@bombadil.infradead.org>
 <CA+zpnLfS4nTjXYYgE_BNcjQPF1vWynOe_118YgTZa9S5G9dVdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zpnLfS4nTjXYYgE_BNcjQPF1vWynOe_118YgTZa9S5G9dVdg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:18:59PM +1000, Thiébaud Weksteen wrote:
> > Can you elaborate on the last sentence? It's unclear how what you
> > describe is used exactly to allow driver to use direct filesystem
> > firmware loading.
> 
> I realize my use of the word "device" here was unfortunate. I meant devices as
> Android devices/systems. This may have contributed to the confusion.
> 
> Previously, Android systems were not setting up the firmware_class.path
> command line argument. It means that the userspace fallback was always
> kicking-in when a driver called request_firmware. This was handled by the
> ueventd process on Android, which is generally given access to all firmware
> files.
> 
> Now that more devices are setting up firmware_class.path, the call to
> request_firmware will end up using kernel_read_file_from_path_initns, which
> would have used the current process credentials.

That makes it crystal clear. This would be useful in the commit log.

> > And, given the feedback from Android it would seem this is a fix
> > which likely may be desirable to backport to some stable kernels?
> 
> Yes, that's right.

Especially in light of this.

  Luis
