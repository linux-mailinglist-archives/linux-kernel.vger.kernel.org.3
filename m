Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA96547991
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiFLJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiFLJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:21:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73426668E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:21:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n197so2199775qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=rUZsUP3gLP5g0/jY+O8Sno6LC4x1+8WTMel44vruJlk=;
        b=OLCpB59fKsD+pgIhg29W6JDu//N2peWFrThEQ91w1LIAw6Wy1cDq5VMwNX5WtTKNX1
         v7e0GtSi6SWsz/jj2uJQH8lxKk85FNKnKyJakRdSUwocmAh5yGFDbHmrFR2HIu1QWO6O
         Fpg2Ryd5AqmUV1gh8tfl+GhjuyHkOUvz2tclc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rUZsUP3gLP5g0/jY+O8Sno6LC4x1+8WTMel44vruJlk=;
        b=TDU53XLVaWmwT18YMx8CfyvT2uJ3RbHJl6RCmUZ0JAuXFMIxpu7KWtM2QjpBmXNMS/
         ogEhk9Phnkk1p4s7sifqKEHGlYt7q+b50zX4mZ0mjGnhah+ZCtaumMAm6/rKi82NkxkH
         H4kAUUxR24QxtMpPQLnsTG7edbtYDzXwPSeddzeO7fS5aAc7I9fr9r74sHLFFvUMuppF
         xXa8WFgvXkMX3fioW6mk8l+xTOcWJixBtPEP3m1Voy4Epp4eXjgb+5gaw8lZyeOA5ilF
         kYY12AEBqUgmdIdA1818OzDBYpqH+9CYMkwYnt9uXO70WosXqxgeeaFLqfPyzvtpcPzL
         VKJA==
X-Gm-Message-State: AOAM533DiE/+1ibbCw/9BvKKhVeMpv8uwrIRi3UIe9RtlcQJFHKdcYGy
        bVP0kHqUQ0LdYc/GcPJCHX0/gudbAhGr0VR0bCsYbv34OTBGbw==
X-Google-Smtp-Source: ABdhPJzg9HGMfpPCYP42nAhNvQ4n+jgJb5U7FUCaD9z/w4nj9Ipmu+O0iDV9W0WJ9nXSfj5sxP03uCw3enLW2Xo56p4=
X-Received: by 2002:a05:620a:288a:b0:6a6:3da1:1a7a with SMTP id
 j10-20020a05620a288a00b006a63da11a7amr36680534qkp.235.1655025702674; Sun, 12
 Jun 2022 02:21:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Sun, 12 Jun 2022 11:21:17 +0200
Message-ID: <CAK8fFZ61mQ3AYpdWjWtyUXzrs-RVMW61mBLrjRDXBxB-F9GzbA@mail.gmail.com>
Subject: Error setting promisc mode with linux 5.18 on ice eth driver
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The system cannot set up promisc mode @ E810-XXV ethernet interface
(ice driver) from linux with kernel 5.18.x (tested 5.18.1, 5.18.2,
5.18.3). It works with 5.17.x.

Reproducer:
$ ip link set em1 promisc on

Dmesg messages:
$ dmesg  | grep 'Error setting promisc'
[   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)

Devices:
$ lspci -s 0000:31:00.0
31:00.0 Ethernet controller: Intel Corporation Ethernet Controller
E810-XXV for SFP (rev 02)
$ lspci -s 0000:b1:00.0
b1:00.0 Ethernet controller: Intel Corporation Ethernet Controller
E810-XXV for SFP (rev 02)

Best regards,
Jaroslav Pulhart
